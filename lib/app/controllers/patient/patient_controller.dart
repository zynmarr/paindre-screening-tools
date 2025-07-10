part of 'patient.dart';

class PatientController {
  final CollectionReference _patients = FirebaseFirestore.instance.collection('patients');

  // final CollectionReference scoringResults = FirebaseFirestore.instance.collection('scoring_results');

  CollectionReference get patients => _patients;

  CollectionReference questionnareScore({required String patientID}) {
    return FirebaseFirestore.instance.collection('patients/$patientID/questionnares_score');
  }

  // ScoringResultController scoringResultController = ScoringResultController();

  /// 🟢 CREATE: Menambahkan pasien baru ke Firestore
  Future<Patient> create(Patient patient) async {
    try {
      DocumentReference docRef = await _patients.add(patient.toMap());
      await docRef.update({'id': docRef.id});
      DocumentSnapshot doc = await docRef.get();
      return Patient.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      Utils.errorToast(message: e.toString());
      return Future.error(e.toString());
    }
  }

  /// 🔵 READ: Mendapatkan semua pasien dari Firestore
  Future getAll(String id) async {
    try {
      QuerySnapshot snapshot = await _patients.doc(id).collection('questionnares_score').get();
      debugPrint(snapshot.docs.map((e) => e.data()).toString());
      // return snapshot.docs.map((doc) => Patient.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      Utils.errorToast(message: e.toString());
      return Future.error(e.toString());
    }
  }

  /// 🔵 READ: Mendapatkan satu pasien berdasarkan ID
  Future<Patient?> getById(String id) async {
    try {
      DocumentSnapshot doc = await _patients.doc(id).get();
      if (doc.exists) {
        return Patient.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      Utils.errorToast(message: e.toString());
      return Future.error(e.toString());
    }
  }

  /// 🟡 UPDATE: Mengupdate data pasien berdasarkan ID
  Future<void> update(String id, Map<String, dynamic> data) async {
    try {
      await _patients.doc(id).update(data);
      Utils.successToast(message: "Data pasien berhasil diperbarui");
    } catch (e) {
      Utils.errorToast(message: e.toString());
      return Future.error(e.toString());
    }
  }

  // Future<void> updateScoring() async {
  //   try {
  //     QuerySnapshot scoringData = await scoringResults.get();
  //     List<ScoringResult> data = scoringData.docs.map((p) => ScoringResult.fromMap(p.data() as Map<String, dynamic>)).toList();
  //     // print(data);
  //     for (ScoringResult item in data) {
  //       await FirebaseFirestore.instance.collection('patients/${item.idPatient}/questionnares_score').get().then((value) async {
  //         for (QueryDocumentSnapshot<Map<String, dynamic>> element in value.docs) {
  //           print(element.id);

  //           await FirebaseFirestore.instance
  //               .collection('patients/${item.idPatient}/questionnares_score')
  //               .doc(element.id)
  //               .update({
  //                 "type": element.data()["type"],
  //                 "value": element.data()['value'],
  //                 "created_at": DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).toString()
  //               });
  //         }
  //       });

  //       // Object? dataPatient = newPatient.docs.first.data();

  //       // for (Map<String, dynamic> que in dataPatient) {
  //       //   que.update('created_at', (value) => 'New', ifAbsent: () => DateTime.now().toString());
  //       //   print(que);
  //       // }
  //       // newPatient.add({
  //       //   "type": item.type,
  //       //   "value": item.value,
  //       // });
  //     }
  //     // await _patients.doc(id).delete();
  //     Utils.successToast(message: "Data pasien berhasil digenerate");
  //   } catch (e) {
  //     Utils.errorToast(message: e.toString());
  //     return Future.error(e.toString());
  //   }
  // }

  /// 🔴 DELETE: Menghapus pasien berdasarkan ID
  Future<void> delete(String id) async {
    try {
      await questionnareScore(patientID: id).get();
      await _patients.doc(id).delete();
      Utils.successToast(message: "Data pasien berhasil dihapus");
    } catch (e) {
      Utils.errorToast(message: e.toString());
      return Future.error(e.toString());
    }
  }

  Future<void> deletePatientAndScores(String patientId) async {
    // Referensi ke koleksi pasien
    DocumentReference patientRef = FirebaseFirestore.instance.collection('patients').doc(patientId);

    // Referensi ke koleksi questionnares_score
    CollectionReference scoresRef = patientRef.collection('questionnares_score');

    // Mulai batch
    WriteBatch batch = FirebaseFirestore.instance.batch();

    try {
      // Ambil semua dokumen dalam koleksi questionnares_score
      QuerySnapshot scoresSnapshot = await scoresRef.get();

      // Tambahkan penghapusan dokumen ke batch
      for (QueryDocumentSnapshot scoreDoc in scoresSnapshot.docs) {
        batch.delete(scoreDoc.reference);
      }

      // Hapus dokumen pasien
      batch.delete(patientRef);

      // Komit batch
      await batch.commit();
      debugPrint("Patient and related scores deleted successfully");
    } catch (e) {
      debugPrint("Failed to delete patient and scores: $e");
    }
  }

  Future createQuestionnareScore({required Patient patient, required ScoringResult data}) async {
    final CollectionReference document = _patients.doc(patient.id).collection('questionnares_score');
    try {
      DocumentReference docRef = await document.add(data.toMap());
      DocumentSnapshot doc = await docRef.get();
      return doc.data();
    } catch (e) {
      Utils.errorToast(message: e.toString());
      return Future.error(e.toString());
    }
  }

  Future<void> exportDataToExcel() async {
    // Ambil data dari Firestore
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('patients').get();

    // Buat workbook baru
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Tambahkan header
    sheet.appendRow([
      TextCellValue('Name'),
      TextCellValue('Age'),
      TextCellValue('Phone Number'),
      TextCellValue('Gender'),
      TextCellValue("Responsible Person"),
      TextCellValue('Created At'),
      TextCellValue('Data Questionnares score'),
    ]); // Ganti dengan nama field Anda

    // Tambahkan data ke sheet
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

      // if (scoresSnapshot.docs.isEmpty) {
      //   sheet.appendRow([
      //     TextCellValue(doc['name'] ?? ''),
      //     TextCellValue(doc['age'] ?? ''),
      //     TextCellValue(doc['phone'] ?? ''),
      //     TextCellValue(doc['gender'] ?? ''),
      //     TextCellValue(doc['responsible_person'] ?? ''),
      //     TextCellValue(doc['created_at'] ?? ''),
      //     TextCellValue('Data Kosong'),
      //   ]);
      // } else {
      //   // Jika ada score, tambahkan data pasien dengan score yang ada
      //   for (var scoreDoc in scoresSnapshot.docs) {
      //     sheet.appendRow([
      //       TextCellValue(doc['name'] ?? ''),
      //       TextCellValue(doc['age'] ?? ''),
      //       TextCellValue(doc['phone'] ?? ''),
      //       TextCellValue(doc['gender'] ?? ''),
      //       TextCellValue(doc['responsible_person'] ?? ''),
      //       TextCellValue(doc['created_at'] ?? ''),
      //       TextCellValue(scoreDoc.data().toString()),
      //     ]);
      //   }
      // }

      // print(doc['name']);
      // sheet.appendRow([
      //   TextCellValue(doc['name'] ?? ''),
      //   TextCellValue(doc['age'] ?? ''),
      //   TextCellValue(doc['phone'] ?? ''),
      //   TextCellValue(doc['gender'] ?? ''),
      //   TextCellValue(doc['responsible_person'] ?? ''),
      //   TextCellValue(doc['created_at'] ?? ''),
      // ]); // Ganti dengan field yang sesuai
    }

    // Simpan file Excel
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    String customPath = '/storage/emulated/0/Download/Backup Database Paindre Screening Tools.xlsx'; // Ganti dengan jalur kustom Anda

    // final directory = await getApplicationDocumentsDirectory();
    final file = File(customPath);
    await file.writeAsBytes(excel.encode()!);

    debugPrint("Data exported to Excel successfully at ${file.path}");
  }
}
