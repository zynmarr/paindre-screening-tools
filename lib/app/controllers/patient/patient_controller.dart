part of 'patient.dart';

class PatientController {
  final CollectionReference _patients = FirebaseFirestore.instance.collection('patients');
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference<Patient> patients = FirebaseFirestore.instance
      .collection('patients')
      .withConverter<Patient>(fromFirestore: (snapshot, _) => Patient.fromMap(snapshot.data()!), toFirestore: (patient, _) => patient.toMap());
  CollectionReference questionnareScore({required String patientID}) {
    return FirebaseFirestore.instance.collection('patients/$patientID/questionnares_score');
  }

  final questionController = Get.find<QuestionController>();
  final isFetching = false.obs;
  final isLoading = false.obs;

  Future<void> createPatient(Patient patient) async {
    final Trace trace = FirebasePerformance.instance.newTrace("create_patient_firestore");
    await trace.start();
    try {
      isLoading.value = true;
      DocumentReference docRef = await patients.add(patient);
      await docRef.update({'id': docRef.id});
      patient = patient.copyWith(id: docRef.id);
      Get.offAllNamed(
        Routes.question,
        arguments: QuestionArguments(question: "Nyeri Nosiseptif", patient: patient),
        predicate: (route) => route.settings.name == Routes.home,
      );
    } catch (e) {
      Utils.errorToast(message: "${'error.message.save'.tr}: ${e.toString()}");
    } finally {
      isLoading.value = false;
      trace.stop();
    }
  }

  Future<void> deletePatientAndScores(String patientId) async {
    final Trace trace = FirebasePerformance.instance.newTrace("delete_patient_and_scores_firestore");
    await trace.start();
    DocumentReference patientRef = FirebaseFirestore.instance.collection('patients').doc(patientId);
    CollectionReference scoresRef = patientRef.collection('questionnares_score');
    WriteBatch batch = FirebaseFirestore.instance.batch();
    try {
      QuerySnapshot scoresSnapshot = await scoresRef.get();
      for (QueryDocumentSnapshot scoreDoc in scoresSnapshot.docs) {
        batch.delete(scoreDoc.reference);
      }
      batch.delete(patientRef);
      await batch.commit();
    } catch (e) {
      Utils.errorToast(message: e.toString());
    } finally {
      trace.stop();
    }
  }

  Future createQuestionnareScore({required Patient patient, required ScoringResult data}) async {
    final Trace trace = FirebasePerformance.instance.newTrace("save_score_to_firestore");
    await trace.start();
    final CollectionReference document = _patients.doc(patient.id).collection('questionnares_score');
    try {
      DocumentReference docRef = await document.add(data.toMap());
      DocumentSnapshot doc = await docRef.get();
      return doc.data();
    } catch (e) {
      Utils.errorToast(message: e.toString());
      return Future.error(e.toString());
    } finally {
      trace.stop();
    }
  }

  Future<String> processAndSaveScore({required String question, required Patient patient, required int sbjScore, required int peScore}) async {
    String textResult;
    String dateFormat = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).toString();
    bool isPainDetected = false;
    String painType = '';
    String painKey = '';
    if (question == 'Nyeri Nosiseptif') {
      painKey = 'pain.nociceptive'.tr;
      if (sbjScore >= 5 && peScore >= 1) isPainDetected = true;
    } else if (question == 'Nyeri Neuropatik') {
      painKey = 'pain.neuropathic'.tr;
      if (sbjScore >= 5 && peScore >= 3) isPainDetected = true;
    } else if (question == 'Nyeri Sensitisasi Sentral') {
      painKey = 'pain.centralSensitization'.tr;
      if (sbjScore >= 8 && peScore >= 4) isPainDetected = true;
    }
    if (isPainDetected) {
      painType = question;
      ScoringResult data = ScoringResult(type: painType, value: (sbjScore + peScore).toString(), createdAt: dateFormat);
      await createQuestionnareScore(patient: patient, data: data);
      textResult = 'text.resultIs'.tr + painKey;
    } else {
      textResult = 'text.resultIsNot'.tr + painKey;
    }
    if (painKey.isEmpty) {
      textResult = 'text.painResultData'.tr;
    }
    return textResult;
  }

  Future<void> exportDataToExcel() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('patients').get();
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];
    sheet.appendRow([
      TextCellValue('Name'),
      TextCellValue('Age'),
      TextCellValue('Phone Number'),
      TextCellValue('Gender'),
      TextCellValue("Responsible Person"),
      TextCellValue('Created At'),
      TextCellValue('Data Questionnares score'),
    ]);
    for (var patientDoc in snapshot.docs) {
      QuerySnapshot scoresSnapshot = await patientDoc.reference.collection('questionnares_score').get();
      Map<String, dynamic> doc = patientDoc.data() as Map<String, dynamic>;
      sheet.appendRow([
        TextCellValue(doc['name'] ?? ''),
        TextCellValue(doc['age'] ?? ''),
        TextCellValue(doc['phone'] ?? ''),
        TextCellValue(doc['gender'] ?? ''),
        TextCellValue(doc['responsible_person'] ?? ''),
        TextCellValue(doc['created_at'] ?? ''),
        TextCellValue(scoresSnapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList().toString()),
      ]);
    }
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    String customPath = '/storage/emulated/0/Download/Backup Database Paindre Screening Tools.xlsx';
    final file = File(customPath);
    await file.writeAsBytes(excel.encode()!);
  }
}
