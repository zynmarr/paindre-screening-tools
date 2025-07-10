import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

part 'translation_controller.dart';

class LanguageModel {
  String imageUrl;
  String languageName;
  String languageCode;
  String countryCode;

  LanguageModel({
    required this.imageUrl,
    required this.languageName,
    required this.countryCode,
    required this.languageCode,
  });
}