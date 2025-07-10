// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:screening_tools_android/app/controllers/service/service_controller.dart';

import '../../../app/routes/routes.dart';

class ErrorArguments {
  final String message;
  final int code;
  ErrorArguments({required this.message, required this.code});
}

class ErrorPage extends StatefulWidget {
  final String message;
  final int code;
  const ErrorPage({super.key, this.message = "Error not found", this.code = 500});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) {
          ServiceController serviceController = context.watch<ServiceController>();
          if (serviceController.connectivityResult != ConnectivityResult.none && widget.code == 503) {
            Future.delayed(Duration(seconds: 3), () {
              Get.offAllNamed(Routes.home);
            });
          }
          return Center(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: Image.asset('assets/images/maintanance_icon.png'),
                    ),
                    SizedBox(height: 20),
                    Text("Error code: ${widget.code}", style: context.textTheme.bodyLarge, textAlign: TextAlign.center),
                    SizedBox(height: 10),
                    Text(widget.message, style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    SizedBox(height: 20),
                    _button(
                      title: 'Refresh',
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _button({void Function()? onPressed, required String title}) {
    return SizedBox(
      // width: context.width / 2,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title.toUpperCase(), style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
