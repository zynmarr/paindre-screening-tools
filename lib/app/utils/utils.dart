import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Utils {
  static goToNextPage(String routesName, {dynamic arguments}) {
    Get.toNamed(routesName, arguments: arguments);
  }

  static paindreShowLoading() {
    BotToast.showCustomLoading(
      align: Alignment.center,
      useSafeArea: true,
      enableKeyboardSafeArea: false,
      duration: const Duration(seconds: 3),
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

  // showDialogAndBack({required String routesName, dynamic arguments}) {
  //   Get.defaultDialog(
  //     barrierDismissible: false,
  //     title: title,
  //     titlePadding: const EdgeInsets.only(top: 15, bottom: 0, left: 8, right: 8),
  //     middleText: middleText,
  //     backgroundColor: Colors.white,
  //     titleStyle: TextStyle(color: Colors.blue[900], fontSize: 22, fontWeight: FontWeight.bold),
  //     middleTextStyle: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
  //     radius: 6,
  //     contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
  //     actions: [
  //       if (confirm != null) confirm,
  //       if (cancel != null) cancel,
  //     ],
  //   );
  //   paindreDialog(
  //     title: "Pemberitahuan",
  //     middleText: "Apakah anda ingin keluar dari halaman ini?",
  //     confirm: paindreButton(
  //       child: const Text("Yes"),
  //       onPressed: () {
  //         Get.back();
  //         Core.goToNextPage(routesName, arguments: arguments);
  //       },
  //     ),
  //     cancel: paindreButton(
  //       child: const Text("No"),
  //       backgroundColor: Colors.red,
  //       onPressed: () {
  //         Get.back();
  //       },
  //     ),
  //   );
  // }
}
