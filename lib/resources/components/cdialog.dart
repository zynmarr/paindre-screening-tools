part of 'components.dart';

cDialog(BuildContext context, {String? title, required String middleText, void Function()? onSucces, void Function()? onCancel}) =>
    Get.defaultDialog(
      barrierDismissible: false,
      title: title ?? 'dialog.title'.tr,
      titlePadding: EdgeInsets.only(top: 15),
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      middleText: middleText,
      titleStyle: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
      middleTextStyle: context.textTheme.bodyMedium,
      radius: 10,
      actions: [
        ElevatedButton(
          onPressed: onSucces,
          child: Text('yes'.tr, style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        ElevatedButton(
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
          onPressed: onCancel,
          child: Text('no'.tr, style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ],
    );
