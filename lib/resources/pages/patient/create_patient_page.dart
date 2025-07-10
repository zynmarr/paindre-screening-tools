import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/controllers/service/service_controller.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';
import 'package:screening_tools_android/resources/pages/question/question_page.dart';

class CreatePatientPage extends StatefulWidget {
  const CreatePatientPage({super.key});

  @override
  State<CreatePatientPage> createState() => _CreatePatientPageState();
}

class _CreatePatientPageState extends State<CreatePatientPage> {
  final formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(text: '0');
  final TextEditingController diagnostiController = TextEditingController(text: 'Kosong');
  String? selectedGender;
  final TextEditingController examinerNameController = TextEditingController();

  final FocusNode fullNameFocus = FocusNode();
  final FocusNode ageFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode diagnosticFocus = FocusNode();
  final FocusNode genderFocus = FocusNode();
  final FocusNode examinerNameFocus = FocusNode();

  CollectionReference featuresDoc = FirebaseFirestore.instance.collection('features');

  bool isPhoneActivated = false;
  bool isDiagnosticActivated = false;
  bool isResponsiblePersonActivated = false;

  String formTitleName = 'form.patient.header'.tr;

  @override
  void initState() {
    super.initState();

    featuresDoc.doc('form_phone').get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      if (data.isNotEmpty) {
        setState(() {
          isPhoneActivated = data['is_activated'] ?? false;
        });
      }
    });

    featuresDoc.doc('form_diagnostic').get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      if (data.isNotEmpty) {
        setState(() {
          isDiagnosticActivated = data['is_activated'] ?? false;
        });
      }
    });

    featuresDoc.doc('form_responsible_person').get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      if (data.isNotEmpty) {
        setState(() {
          isResponsiblePersonActivated = data['is_activated'] ?? false;
        });
      }
    });

    // featuresDoc.doc('form_examination').get().then((value) {
    //   Map<String, dynamic> data = value.data() as Map<String, dynamic>;
    //   if (data.isNotEmpty) {
    //     setState(() {
    //       formTitleName = data['title'] ?? "Form Pemeriksaan";
    //     });
    //   }
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fullNameController.text = user?.displayName ?? '';
    examinerNameController.text = user?.displayName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    ServiceController serviceController = context.watch<ServiceController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.grey[300],
      body: SizedBox(
        height: context.height,
        child: Stack(
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
            SizedBox(
              height: context.height,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Text(
                      formTitleName.toUpperCase(),
                      textAlign: TextAlign.left,
                      style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.blue[800]),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 4)],
                      ),
                      child: Form(
                        key: formKey,
                        child: Container(
                          width: context.width,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              cTextField(
                                label: 'form.patient.name'.tr,
                                controller: fullNameController,
                                focusNode: fullNameFocus,
                                keyboardType: TextInputType.text,
                                hintText: 'hint.name'.tr,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5, style: BorderStyle.solid),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                              cTextField(
                                label: 'form.patient.age'.tr,
                                controller: ageController,
                                focusNode: ageFocus,
                                keyboardType: TextInputType.number,
                                hintText: 'hint.age'.tr,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5, style: BorderStyle.solid),
                                ),
                              ),
                              if (isPhoneActivated || serviceController.role == Roles.admin)
                                const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                              if (isPhoneActivated || serviceController.role == Roles.admin)
                                cTextField(
                                  label: 'form.patient.phone'.tr,
                                  controller: phoneController,
                                  focusNode: phoneFocus,
                                  keyboardType: TextInputType.number,
                                  hintText: 'hint.phone'.tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5, style: BorderStyle.solid),
                                  ),
                                ),
                              if (isDiagnosticActivated) const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                              if (isDiagnosticActivated)
                                cTextField(
                                  label: 'form.patient.diagnosis'.tr,
                                  controller: diagnostiController,
                                  focusNode: diagnosticFocus,
                                  keyboardType: TextInputType.text,
                                  hintText: 'Masukkan diagnosa',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5, style: BorderStyle.solid),
                                  ),
                                ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                              _buildGenderDropdown(),
                              if (isPhoneActivated || isResponsiblePersonActivated) const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                              if (isPhoneActivated || isResponsiblePersonActivated)
                                cTextField(
                                  label: 'form.patient.examinerName'.tr,
                                  controller: examinerNameController,
                                  focusNode: examinerNameFocus,
                                  keyboardType: TextInputType.text,
                                  hintText: 'hint.examinerName'.tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5, style: BorderStyle.solid),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                    SizedBox(
                      width: context.width / 3,
                      child: ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            cDialog(
                              context,
                              middleText: 'dialog.save'.tr,
                              onSucces: () async {
                                Patient patientData = Patient(
                                  id: "1",
                                  name: fullNameController.text,
                                  age: ageController.text,
                                  gender: selectedGender ?? '',
                                  phone: phoneController.text,
                                  responsiblePerson: examinerNameController.text,
                                  diagnostic: diagnostiController.text,
                                  userID: user?.uid ?? '',
                                  createdAt: DateTime.now().toString(),
                                );
                                Utils.paindreShowLoading();
                                await PatientController().create(patientData).then((value) {
                                  Get.offAllNamed(
                                    Routes.question,
                                    arguments: QuestionArguments(question: "Nyeri Nosiseptif", patient: value),
                                    predicate: (route) => route.settings.name == Routes.home,
                                  );
                                });
                              },
                              onCancel: () => Get.back(),
                            );
                          }
                        },
                        child: Text(
                          'button.save'.tr.toUpperCase(),
                          style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text formTitle({required String title}) {
    return Text(title, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold));
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        formTitle(title: 'form.patient.gender'.tr),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        DropdownButtonFormField<String>(
          value: selectedGender,
          dropdownColor: Colors.white,
          items: [
            DropdownMenuItem(value: null, child: Text('select.gender'.tr, style: context.textTheme.bodyMedium)),
            DropdownMenuItem(value: 'male', child: Text('man'.tr, style: context.textTheme.bodyMedium)),
            DropdownMenuItem(value: 'female', child: Text('woman'.tr, style: context.textTheme.bodyMedium)),
          ],
          validator: (value) {
            if (value == null) {
              return 'select.gender'.tr;
            }
            return null;
          },
          decoration: cInputDecoration(
            hintText: 'form.patient.gender'.tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5, style: BorderStyle.solid),
            ),
          ),
          onChanged: (val) {
            setState(() {
              selectedGender = val;
            });
          },
        ),
      ],
    );
  }
}
