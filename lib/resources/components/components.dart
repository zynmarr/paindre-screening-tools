import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screening_tools_android/app/utils/utils.dart';

part 'cappbar.dart';
part 'ccard.dart';
part 'cdialog.dart';

String painName(String type) {
  switch (type) {
    case 'Nyeri Nosiseptif':
      return 'pain.nociceptive'.tr;
    case 'Nyeri Neuropatik':
      return 'pain.neuropathic'.tr;
    case 'Nyeri Sensitisasi Sentral':
      return 'pain.centralSensitization'.tr;
    default:
      return type;
  }
}

Widget textKeyWithValue(BuildContext context, {String? key, String? value, int maxLines = 1}) {
  return RichText(
    maxLines: maxLines,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      style: context.textTheme.bodyMedium!.copyWith(color: Colors.black),
      children: [TextSpan(text: key, style: GoogleFonts.viga()), TextSpan(text: value)],
    ),
  );
}

ListTile itemCard({required String text}) {
  return ListTile(
    leading: Icon(MdiIcons.minus),
    title: Text(text, style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
    horizontalTitleGap: 4,
    minLeadingWidth: 0,
    minVerticalPadding: 0,
    visualDensity: VisualDensity.compact,
    contentPadding: const EdgeInsets.symmetric(),
  );
}

InputDecoration cInputDecoration({String? hintText, Widget? suffixIcon, InputBorder? border}) => InputDecoration(
  fillColor: Colors.white,
  hintText: hintText,
  filled: true,
  hintStyle: Get.textTheme.bodyMedium,
  errorStyle: Get.textTheme.labelMedium!.copyWith(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
  suffixIcon: suffixIcon,
  border: border,
  enabledBorder: border,
);

LinearGradient cGradient(BuildContext context) => LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [Colors.blue[200]!, Colors.blue[200]!, context.theme.colorScheme.primary],
);

cLoading() {
  return Container(
    height: 80,
    width: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [SpinKitWave(color: Colors.blue[900], size: 30.0)],
    ),
  );
}

Widget cTextField({
  String label = "Label Text",
  TextEditingController? controller,
  FocusNode? focusNode,
  TextInputType? keyboardType,
  String? hintText,
  String? Function(String?)? validator,
  InputBorder? border,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      TextFormField(
        showCursor: true,
        controller: controller,
        focusNode: focusNode,
        style: Get.textTheme.bodyMedium!,
        keyboardType: keyboardType,
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'validation.required'.tr;
              }
              if (keyboardType == TextInputType.name && !RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                return 'validation.invalidInput'.tr;
              }
              if (keyboardType == TextInputType.emailAddress && !GetUtils.isEmail(value)) {
                return 'validation.invalidEmail'.tr;
              }
              if (keyboardType == TextInputType.phone && !GetUtils.isPhoneNumber(value)) {
                return 'validation.invalidPhone'.tr;
              }
              if (keyboardType == TextInputType.number && !GetUtils.isNumericOnly(value)) {
                return 'validation.invalidNumber'.tr;
              }
              if (keyboardType == TextInputType.url && !GetUtils.isURL(value)) {
                return 'validation.invalidURL'.tr;
              }
              if (keyboardType != TextInputType.url && keyboardType != TextInputType.emailAddress && (value.startsWith('http') || value.startsWith('https') || value.contains('.') || GetUtils.isURL(value))) {
                return 'validation.detectURL'.tr;
              }

              return null;
            },
        decoration: cInputDecoration(hintText: hintText, border: border),
      ),
    ],
  );
}

Widget cPasswordField({
  String label = "Label Text",
  TextEditingController? controller,
  FocusNode? focusNode,
  bool isObsecure = true,
  VoidCallback? onObsecure,
  String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      TextFormField(
        showCursor: true,
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.visiblePassword,
        obscureText: isObsecure,
        style: Get.textTheme.bodyMedium!,
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'validation.required'.tr;
              }
              if (value.length < 8) {
                return 'validation.password.minLength'.tr;
              }
              if (value.startsWith('http') || value.startsWith('https') || GetUtils.isURL(value)) {
                return 'validation.detectURL'.tr;
              }
              return null;
            },
        decoration: cInputDecoration(
          hintText: 'hint.password'.tr,
          suffixIcon: IconButton(onPressed: onObsecure, icon: Icon(isObsecure ? MdiIcons.eyeOff : MdiIcons.eye, size: 18)),
        ),
      ),
    ],
  );
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintFill0 =
        Paint()
          ..color = Colors.blue[900]!
          ..style = PaintingStyle.fill
          ..strokeWidth = size.width * 0.00
          ..strokeCap = StrokeCap.butt
          ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.5714286);
    path_0.lineTo(size.width * 0.0008333, size.height * 1.0014286);
    path_0.lineTo(size.width, size.height * 0.9985714);
    path_0.lineTo(size.width * 0.9991667, size.height * 0.0080286);
    path_0.quadraticBezierTo(size.width * 0.7377083, size.height * 0.0650000, size.width * 0.5008333, size.height * 0.3328571);
    path_0.quadraticBezierTo(size.width * 0.2912500, size.height * 0.6289286, 0, size.height * 0.5714286);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);
    Paint paintStroke0 =
        Paint()
          ..color = const Color.fromARGB(255, 33, 150, 243)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.00
          ..strokeCap = StrokeCap.butt
          ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paintFill0 =
        Paint()
          ..color = Colors.amber[600]!
          ..style = PaintingStyle.fill
          ..strokeWidth = size.width * 0.00
          ..strokeCap = StrokeCap.butt
          ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.5714286);
    path_0.lineTo(size.width * 0.0008333, size.height * 1.0014286);
    path_0.lineTo(size.width, size.height * 0.9985714);
    path_0.lineTo(size.width * 0.9995667, size.height * 0.0000286);
    path_0.quadraticBezierTo(size.width * 0.7477083, size.height * 0.0850000, size.width * 0.5198533, size.height * 0.3488571);
    path_0.quadraticBezierTo(size.width * 0.2916500, size.height * 0.6289286, 0, size.height * 0.5224286);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
