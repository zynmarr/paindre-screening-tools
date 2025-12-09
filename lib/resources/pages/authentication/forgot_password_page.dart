import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/authentication/authentication_controller.dart';
import 'package:screening_tools_android/resources/components/components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthenticationController>();
  final TextEditingController emailController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Panggil fungsi reset password dari controller
      await _authController.sendPasswordResetEmail(emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: cAppBar(
        title: 'text.resetPassword'.tr,
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
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Text(
                      'text.forgotPasswordInstruction'.tr,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge!.copyWith(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 30),
        
                    // Input Email
                    cTextField(
                      label: 'email'.tr,
                      hintText: 'hint.email'.tr,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'validation.email.required'.tr; // Pastikan email tidak kosong
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'validation.invalidEmail'.tr; // Validasi format email
                        }
                        return null;
                      },
                    ),
        
                    const SizedBox(height: 30),
        
                    // Tombol Submit (Menggunakan Inline Loading)
                    Obx(() {
                      final bool isLoading = _authController.isLoading.value;
                      return SizedBox(
                        width: context.width / 2,
                        child: ElevatedButton(
                          onPressed: isLoading ? () {} : _submitForm,
                          style: ElevatedButton.styleFrom(
                            // Menggunakan warna Grey[600] yang Anda sukai saat loading
                            backgroundColor: isLoading ? Colors.grey[600] : Colors.blue[800],
                          ),
                          child:
                              isLoading
                                  ? const SpinKitFadingCircle(color: Colors.white, size: 25.0)
                                  : Text(
                                    'text.sendResetLink'.tr.toUpperCase(),
                                    style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
