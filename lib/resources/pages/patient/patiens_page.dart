import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/resources/components/components.dart';
import 'package:screening_tools_android/resources/pages/patient/detail_patient_page.dart';

class PatientArguments {
  final bool isHistory;
  PatientArguments({required this.isHistory});
}

class PatientPage extends StatefulWidget {
  final bool isHistory;
  const PatientPage({super.key, required this.isHistory});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final query =
        widget.isHistory
            ? PatientController().patients.where('user_id', isEqualTo: user!.uid).orderBy('created_at', descending: true)
            : PatientController().patients.orderBy('created_at', descending: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: cAppBar(
        title: widget.isHistory ? 'screeningData'.tr : 'patientData'.tr,
        centerTitle: true,
        leading: GestureDetector(onTap: () => Get.back(), child: Icon(MdiIcons.chevronLeft, size: 20)),
      ),
      body: Stack(
        children: [
          Positioned(
            left: -1,
            right: -2,
            bottom: 0,
            child: CustomPaint(size: Size(context.width, context.height / 1.9), painter: RPSCustomPainter1()),
          ),
          Positioned(
            left: -2,
            right: -2,
            bottom: -2,
            child: CustomPaint(size: Size(context.width, context.height / 2.0), painter: RPSCustomPainter2()),
          ),
          FirestoreListView<Patient>(
            query: query,
            pageSize: 10, // Tentukan berapa banyak item yang di-load setiap kali
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            loadingBuilder: (context) => Center(child: cLoading()),
            emptyBuilder:
                (context) => Center(
                  child: Text(
                    "Belum ada data pemeriksaan",
                    style: context.textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
            errorBuilder:
                (context, error, stackTrace) => Center(
                  child: Text(
                    "Terjadi kesalahan: ${error.toString()}",
                    style: context.textTheme.bodyLarge!.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
            itemBuilder: (context, doc) {
              final patient = doc.data(); // doc sudah otomatis di-deserialize menjadi objek Patient
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.detailPatient, arguments: DetailPatientArguments(patient: patient));
                },
                child: patientCard(context, patient: patient),
              );
            },
          ),
        ],
      ),
    );
  }
}
