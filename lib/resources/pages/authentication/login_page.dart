import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final AuthenticationController _authController = AuthenticationController();

  bool obSecure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      try {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        await _authController.loginWithEmailAndPassword(email: email, password: password);
      } catch (error) {
        Utils.errorToast(message: "${'error.message.login'.tr}${error.toString()}");
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      await _authController.loginWithGoogle();
    } catch (e) {
      Utils.errorToast(message: "${'error.message.loginWithGoogle'.tr}${e.toString()}");
    }
  }

  Future<void> _loginWithApple() async {
    try {
      await _authController.loginWithApple();
    } catch (e) {
      Utils.errorToast(message: e.toString());
    }
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
                          const SizedBox(height: 10),
                          _buildAppleLoginButton(),
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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 4)],
        ),
        child: Column(
          children: [
            cTextField(
              label: 'email'.tr,
              controller: emailController,
              focusNode: emailFocus,
              keyboardType: TextInputType.emailAddress,
              hintText: 'hint.email'.tr,
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
            const SizedBox(height: 8),
            // Text('text.forgotPassword'.tr, style: context.textTheme.bodyMedium!.copyWith(color: Colors.blue[800], fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.forgotPassword),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    child: Text('text.forgotPassword'.tr, style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.blue[800])),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: context.width / 2,
      child: Obx(() {
        bool isLoading = _authController.isLoading.value;
        return ElevatedButton(
          onPressed: isLoading ? () {} : _login,
          style: ElevatedButton.styleFrom(
            backgroundColor: WidgetStateColor.resolveWith((states) {
              if (isLoading) return Colors.grey[600]!;
              return Colors.blue[800]!;
            }),
          ),
          child:
              isLoading
                  ? const SpinKitFadingCircle(color: Colors.white, size: 25.0)
                  : Text(
                    'button.login'.tr.toUpperCase(),
                    style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
        );
      }),
    );
  }

  SizedBox _buildGoogleLoginButton() {
    return SizedBox(
      width: context.width / 2,
      child: Obx(() {
        bool isLoading = _authController.isLoading.value;
        return ElevatedButton.icon(
          onPressed: isLoading ? () {} : _loginWithGoogle,
          style: ElevatedButton.styleFrom(
            backgroundColor: WidgetStateColor.resolveWith((states) {
              if (isLoading) return Colors.grey[600]!;
              return Colors.red;
            }),
          ),
          icon: isLoading ? SizedBox() : Icon(MdiIcons.google, color: Colors.white),
          label:
              isLoading
                  ? const SpinKitFadingCircle(color: Colors.white, size: 25.0)
                  : Text('Login With Google', style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        );
      }),
    );
  }

  SizedBox _buildAppleLoginButton() {
    return SizedBox(
      width: context.width / 2,
      child: Obx(() {
        bool isLoading = _authController.isLoading.value;
        return ElevatedButton.icon(
          onPressed: isLoading ? () {} : _loginWithApple,
          style: ElevatedButton.styleFrom(
            backgroundColor: WidgetStateColor.resolveWith((states) {
              if (isLoading) return Colors.grey[600]!;
              return Colors.black;
            }),
          ),
          icon: isLoading ? SizedBox() : Icon(MdiIcons.apple, color: Colors.white),
          label:
              isLoading
                  ? const SpinKitFadingCircle(color: Colors.white, size: 25.0)
                  : Text('Login With Apple', style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        );
      }),
    );
  }

  Container _buildFooter() {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('text.dontHaveAccount'.tr, style: context.textTheme.bodyLarge),
          // const SizedBox(width: 4),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.register),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              child: Text('button.register'.tr, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
