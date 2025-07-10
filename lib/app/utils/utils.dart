import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Utils {
  static goToNextPage(String routesName, {dynamic arguments}) {
    Get.offAndToNamed(routesName, arguments: arguments);
  }

  static paindreShowLoading() {
    BotToast.showCustomLoading(
      align: Alignment.center,
      useSafeArea: true,
      enableKeyboardSafeArea: false,
      duration: const Duration(seconds: 20),
      backgroundColor: Colors.black45,
      toastBuilder: (cancelFunc) {
        return Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            // color: const Color.fromARGB(211, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitWave(
                color: Colors.white,
                size: 30.0,
              ),
            ],
          ),
        );
      },
    );
  }

  static errorToast({String? message}) {
    BotToast.showSimpleNotification(
      title: "Error message",
      titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      subTitle: message,
      subTitleStyle: const TextStyle(color: Colors.white),
      backgroundColor: Colors.redAccent,
      closeIcon: Icon(
        MdiIcons.closeCircle,
        color: Colors.white,
      ),
    );
  }

  static successToast({String? message}) {
    BotToast.showSimpleNotification(
      title: "Success message",
      titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      subTitle: message,
      subTitleStyle: const TextStyle(color: Colors.white),
      backgroundColor: Colors.cyan,
    );
  }

  static ymdFormat({DateTime? dateTime}) {
    return DateFormat("y-M-d").format(dateTime ?? DateTime.now());
  }
}
