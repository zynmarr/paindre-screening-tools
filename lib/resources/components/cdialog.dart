part of 'components.dart';

cDialog(BuildContext context, {String title = "Pemberitahuan", required String middleText, void Function()? onSucces, void Function()? onCancel}) => Get.defaultDialog(
      barrierDismissible: false,
      title: title.toUpperCase(),
      middleText: middleText,
      // contentPadding: EdgeInsets.all(),
      titleStyle: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
      middleTextStyle: context.textTheme.bodyLarge,
      radius: 10,
      actions: [
        ElevatedButton(
          onPressed: onSucces,
          child: Text(
            'Iya',
            style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
          onPressed: onCancel,
          child: Text(
            'Tidak',
            style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
