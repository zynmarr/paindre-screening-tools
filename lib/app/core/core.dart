import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'theme.dart';
part 'translations.dart';

class Core {
  static String website = 'https://paindre-screening-tools.paindre-monitoring.net';

  static Uri url({String prefix = ''}) => prefix.isEmpty ? Uri.parse("$website/api") : Uri.parse('$website/api/$prefix');
}
