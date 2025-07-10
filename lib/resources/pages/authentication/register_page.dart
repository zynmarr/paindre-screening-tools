import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screening_tools_android/app/controllers/authentication/authentication_controller.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final AuthController _authController = AuthController();

  bool _isObscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
          SizedBox(
            height: context.height,
            width: context.width,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        SizedBox(
                          width: context.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('text.headline.register.1'.tr, style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold)),
                              Text('text.headline.register.2'.tr, style: context.textTheme.headlineSmall!.copyWith(color: Colors.grey[800])),
                            ],
                          ),
                        ),
                        const SizedBox(height: 90),
                        _formBody(),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                        _registerButton(),
                      ],
                    ),
                  ),
                ),
                _footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form _formBody() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 4)],
        ),
        child: Column(
          children: [
            // Text("Register", style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
            // const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            cTextField(
              label: 'name'.tr,
              controller: _nameController,
              focusNode: _nameFocusNode,
              keyboardType: TextInputType.name,
              hintText: 'hint.name'.tr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'validation.name.required'.tr;
                }
                return null;
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            cTextField(
              label: 'email'.tr,
              controller: _emailController,
              focusNode: _emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              hintText: 'hint.email'.tr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'validation.email.required'.tr;
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'validation.invalidEmail'.tr;
                }
                return null;
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            cPasswordField(
              label: 'password'.tr,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              isObsecure: _isObscurePassword,
              onObsecure: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'validation.password.required'.tr;
                }
                if (value.length < 6) {
                  return 'validation.password.minLength'.tr; // Pastikan password minimal 6 karakter
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _registerButton() {
    return SizedBox(
      width: context.width / 3,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Utils.paindreShowLoading(); // Tampilkan loading
            try {
              // Ambil email dan password dari controller
              String name = _nameController.text;
              String email = _emailController.text.trim();
              String password = _passwordController.text.trim();

              // Mendaftar dengan email dan password
              await _authController.registerWithEmailAndPassword(name: name, email: email, password: password);
              // Jika pendaftaran berhasil, navigasi ke halaman home atau halaman lain
              Get.offNamed(Routes.login);
              Utils.successToast(message: 'success.message.register'.tr);
            } catch (error) {
              // Tangani kesalahan pendaftaran
              Utils.errorToast(message: error.toString());
            } finally {
              // Tutup loading di akhir
              BotToast.closeAllLoading();
            }
          }
        },
        child: Text('button.register'.tr.toUpperCase(), style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Container _footer() {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(vertical: 14),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('text.haveAccount'.tr, style: context.textTheme.bodyLarge),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text('button.login'.tr, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
