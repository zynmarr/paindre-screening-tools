import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool obSecure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        body: SizedBox(
          height: context.height,
          width: context.width,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 90),
                      SizedBox(
                        width: context.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Belum Punya Akun?", style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold)),
                            Text("Silahkan daftar akun anda disini", style: context.textTheme.headlineSmall!.copyWith(color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Form(
                        key: formKey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text("Register", style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name", style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                                  TextFormField(
                                    showCursor: true,
                                    controller: emailC,
                                    focusNode: emailFocus,
                                    style: context.textTheme.bodyMedium!,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email tidak boleh kosong';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: cInputDecoration(context, hintText: 'Masukkan email'),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email", style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                                  TextFormField(
                                    showCursor: true,
                                    controller: emailC,
                                    focusNode: emailFocus,
                                    style: context.textTheme.bodyMedium!,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email tidak boleh kosong';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: cInputDecoration(context, hintText: 'Masukkan email'),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Password", style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                                  TextFormField(
                                    showCursor: true,
                                    controller: passwordC,
                                    focusNode: passwordFocus,
                                    obscureText: obSecure,
                                    style: context.textTheme.bodyMedium!,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password tidak boleh kosong';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: cInputDecoration(
                                      context,
                                      hintText: 'Masukkan password',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obSecure = !obSecure;
                                          });
                                        },
                                        icon: Icon(
                                          obSecure ? MdiIcons.eyeOff : MdiIcons.eye,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                      SizedBox(
                        width: context.width / 3,
                        child: ElevatedButton(
                          onPressed: () async {
                            Utils.goToNextPage('home-page');
                          },
                          child: Text(
                            'Register'.toUpperCase(),
                            style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: context.width,
                padding: const EdgeInsets.symmetric(vertical: 14),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sudah punya akun?', style: context.textTheme.bodyLarge),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('login-page');
                      },
                      child: Text('Masuk', style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
