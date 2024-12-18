import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'theme.dart';

class Core {
  static String website = 'https://paindre-screening-tools.paindre-monitoring.net';
  // static String website = 'http://192.168.90.23:8000';
  //static String url = 'http://192.168.170.214:8000';

  static Uri url({String prefix = ''}) => prefix.isEmpty ? Uri.parse("$website/api") : Uri.parse('$website/api/$prefix');
}
