import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

part 'cappbar.dart';
part 'ccard.dart';
part 'cdialog.dart';

Widget textKeyWithValue(BuildContext context, {String? key, String? value, int maxLines = 1}) {
  return RichText(
    maxLines: maxLines,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      style: context.textTheme.bodyMedium!.copyWith(color: Colors.black),
      children: [
        TextSpan(
          text: key,
          style: GoogleFonts.viga(),
        ),
        TextSpan(
          text: value,
        ),
      ],
    ),
  );
}

ListTile itemCard(BuildContext context, {required String text}) {
  return ListTile(
    leading: Icon(MdiIcons.minus),
    title: Text(
      text,
      style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
    ),
    horizontalTitleGap: 4,
    minLeadingWidth: 0,
    minVerticalPadding: 0,
    visualDensity: VisualDensity.compact,
    contentPadding: const EdgeInsets.symmetric(),
  );
}

InputDecoration cInputDecoration(
  BuildContext context, {
  String? hintText,
  Widget? suffixIcon,
}) =>
    InputDecoration(
      fillColor: Colors.white,
      hintText: hintText,
      filled: true,
      hintStyle: context.textTheme.bodyMedium,
      errorStyle: context.textTheme.labelMedium!.copyWith(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
      suffixIcon: suffixIcon,
    );


    LinearGradient cGradient(BuildContext context) => LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue[200]!,
                Colors.blue[200]!,
                context.theme.colorScheme.primary,
              ],
            );
