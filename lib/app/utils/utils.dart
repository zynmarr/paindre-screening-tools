import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/foundation.dart';

class Utils {
  static void appPrint(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }

  static goToNextPage(String routesName, {dynamic arguments}) {
    Get.offAndToNamed(routesName, arguments: arguments);
  }

  static errorToast({String? message}) {
    BotToast.showSimpleNotification(
      title: "Error message",
      titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      subTitle: message,
      subTitleStyle: const TextStyle(color: Colors.white),
      backgroundColor: Colors.redAccent,
      closeIcon: Icon(MdiIcons.closeCircle, color: Colors.white),
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
