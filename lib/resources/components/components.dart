import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/pages/patient/detail_patient_page.dart';

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
      // color: const Color.fromARGB(211, 255, 255, 255),
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
        obscureText: isObsecure,
        style: Get.textTheme.bodyMedium!,
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'validation.required'.tr;
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
    // Layer 1
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

    // Layer 1
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
    // Layer 1

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
