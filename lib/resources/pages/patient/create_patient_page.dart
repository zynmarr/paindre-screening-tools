import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/controllers/service/service_controller.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class CreatePatientPageProvider extends StatelessWidget {
  const CreatePatientPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreatePatientPage();
  }
}

class CreatePatientPage extends StatefulWidget {
  const CreatePatientPage({super.key});

  @override
  State<CreatePatientPage> createState() => _CreatePatientPageState();
}

class _CreatePatientPageState extends State<CreatePatientPage> {
  final _formKey = GlobalKey<FormState>();
  final _patientController = PatientController();
  final _user = FirebaseAuth.instance.currentUser;
  late final TextEditingController _fullNameController;
  late final TextEditingController _ageController;
  late final TextEditingController _phoneController;
  late final TextEditingController _diagnostiController;
  late final TextEditingController _examinerNameController;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: _user?.displayName ?? '');
    _ageController = TextEditingController();
    _phoneController = TextEditingController(text: '0');
    _diagnostiController = TextEditingController(text: 'Kosong');
    _examinerNameController = TextEditingController(text: _user?.displayName ?? '');
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<CreatePatientState>().fetchFormConfiguration();
    // });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _diagnostiController.dispose();
    _examinerNameController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newPatient = Patient(
        id: 'temp_id',
        name: _fullNameController.text,
        age: _ageController.text,
        gender: _selectedGender ?? '',
        phone: _phoneController.text,
        diagnostic: _diagnostiController.text,
        responsiblePerson: _examinerNameController.text,
        userID: _user?.uid ?? '',
        createdAt: DateTime.now().toString(),
      );

      cDialog(
        context,
        middleText: 'dialog.save'.tr,
        onSucces: () async {
          Get.back(); // Tutup dialog konfirmasi
          await _patientController.createPatient(newPatient);
        },
        onCancel: () => Get.back(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Ubah ke true untuk layout yang lebih baik
      appBar: cAppBar(
        title: 'button.startScreening'.tr,
        centerTitle: true,
        leading: GestureDetector(onTap: () => Get.back(), child: Icon(MdiIcons.chevronLeft, size: 20)),
      ),
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
            Selector<ServiceController, bool>(
              selector: (context, controller) => controller.role == Roles.admin,
              builder: (context, isUserAdmin, child) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        'form.patient.header'.tr,
                        style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.blue[800]),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4)],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cTextField(
                                label: 'form.patient.name'.tr,
                                controller: _fullNameController,
                                hintText: 'hint.name'.tr,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5, style: BorderStyle.solid),
                                ),
                              ),
                              const SizedBox(height: 12),
                              cTextField(
                                label: 'form.patient.age'.tr,
                                controller: _ageController,
                                keyboardType: TextInputType.number,
                                hintText: 'hint.age'.tr,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5, style: BorderStyle.solid),
                                ),
                              ),
                              const SizedBox(height: 12),
                              if (isUserAdmin) ...[
                                cTextField(
                                  label: 'form.patient.phone'.tr,
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  hintText: 'hint.phone'.tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5, style: BorderStyle.solid),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                              if (isUserAdmin) ...[
                                cTextField(
                                  label: 'form.patient.diagnosis'.tr,
                                  controller: _diagnostiController,
                                  hintText: 'Masukkan diagnosa',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5, style: BorderStyle.solid),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                              _buildGenderDropdown(),
                              const SizedBox(height: 12),
                              if (isUserAdmin) ...[
                                cTextField(
                                  label: 'form.patient.examinerName'.tr,
                                  controller: _examinerNameController,
                                  hintText: 'hint.examinerName'.tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5, style: BorderStyle.solid),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: context.width / 3,
                        child: Obx(() {
                          final bool isLoading = _patientController.isLoading.value;
                          return ElevatedButton(
                            onPressed: isLoading ? () {} : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isLoading ? Colors.grey[600] : Colors.blue[800],
                            ),
                            child:
                                isLoading
                                    ? const SpinKitFadingCircle(color: Colors.white, size: 25.0)
                                    : Text(
                                      'button.save'.tr.toUpperCase(),
                                      style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('form.patient.gender'.tr, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _selectedGender,
          dropdownColor: Colors.white,
          items: [
            DropdownMenuItem(value: null, child: Text('select.gender'.tr, style: context.textTheme.bodyMedium)),
            DropdownMenuItem(value: 'male', child: Text('man'.tr, style: context.textTheme.bodyMedium)),
            DropdownMenuItem(value: 'female', child: Text('woman'.tr, style: context.textTheme.bodyMedium)),
          ],
          validator: (value) => value == null ? 'select.gender'.tr : null,
          decoration: cInputDecoration(
            hintText: 'form.patient.gender'.tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5, style: BorderStyle.solid),
            ),
          ),
          onChanged: (val) => setState(() => _selectedGender = val),
        ),
      ],
    );
  }
}
