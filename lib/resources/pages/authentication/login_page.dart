import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/authentication/authentication_controller.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final AuthController _authController = AuthController();

  bool obSecure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: context.height,
        width: context.width,
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
              width: context.width,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          _buildHeader(context),
                          const SizedBox(height: 90),
                          _buildLoginForm(context),
                          const SizedBox(height: 20),
                          _buildLoginButton(context),
                          const SizedBox(height: 10),
                          _buildGoogleLoginButton(),
                        ],
                      ),
                    ),
                  ),
                  _buildFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildHeader(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('text.welcomeInLogin'.tr, style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold)),
          Text('text.loginFirst'.tr, style: context.textTheme.headlineSmall!.copyWith(color: Colors.grey[800])),
        ],
      ),
    );
  }

  Form _buildLoginForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 4)],
        ),
        child: Column(
          children: [
            // Text("Login", style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
            // const SizedBox(height: 8),
            cTextField(
              label: 'email'.tr,
              controller: emailController,
              focusNode: emailFocus,
              keyboardType: TextInputType.emailAddress,
              hintText: 'hint.email'.tr,
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
            const SizedBox(height: 8),
            cPasswordField(
              label: 'password'.tr,
              controller: passwordController,
              focusNode: passwordFocus,
              isObsecure: obSecure,
              onObsecure: () {
                setState(() {
                  obSecure = !obSecure;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'validation.password.required'.tr; // Pastikan password tidak kosong
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: context.width / 2,
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            Utils.paindreShowLoading();
            try {
              String email = emailController.text.trim();
              String password = passwordController.text.trim();

              await _authController.loginWithEmailAndPassword(email: email, password: password);
              Get.offNamed(Routes.home);
              Utils.successToast(message: 'success.message.login'.tr);
            } catch (error) {
              Utils.errorToast(message: "${'error.message.login'.tr}${error.toString()}");
            } finally {
              BotToast.closeAllLoading();
            }
          }
        },
        child: Text('button.login'.tr.toUpperCase(), style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  SizedBox _buildGoogleLoginButton() {
    return SizedBox(
      width: context.width / 2,
      child: ElevatedButton.icon(
        onPressed: () async {
          Utils.paindreShowLoading();
          try {
            await _authController.loginWithGoogle();
            Get.offNamed(Routes.home);
            Utils.successToast(message: 'success.message.login'.tr);
          } catch (e) {
            Utils.errorToast(message: "${'error.message.loginWithGoogle'.tr}${e.toString()}");
          } finally {
            BotToast.closeAllLoading();
          }
        },
        icon: Icon(MdiIcons.google, color: Colors.white),
        label:  Text('text.loginWithGoogle'.tr, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
      ),
    );
  }

  Container _buildFooter() {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(vertical: 14),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('text.dontHaveAccount'.tr, style: context.textTheme.bodyLarge),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.register),
            child: Text('button.register'.tr, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
