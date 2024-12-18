part of 'patient.dart';

class PatientController extends ChangeNotifier {

  CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');

  Future<Patient> create(Patient patient) async {
    return patients.add(patient.toMap()).then((value) async {
      await value.update({'id': value.id});
      return await value.get().then((c) {
        print("${c.data()}");
        return Patient.fromMap(c.data() as Map<String, dynamic>);
      });
    }).onError((Handler error, stackTrace) {
      Utils.errorToast(message: error.message);
      return Future.error(error.message);
    });
  }
}
