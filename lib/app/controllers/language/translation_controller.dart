part of 'language.dart';
class LocalizationController extends GetxController {
  // final GetStorage sharedPreferences;

  LocalizationController() {
    loadCurrentLanguage();
  }

  Locale _locale = Locale('en', 'US');
  int _selectedIndex = 0;

  Locale get locale => _locale;

  void loadCurrentLanguage() {
    // Load the current language from shared preferences
  }

  void setLanguage(Locale locale) {
    _locale = locale;
    saveLanguage(locale);
    update();
  }

  void saveLanguage(Locale locale) async {
    // sharedPreferences.setString('language_code', locale.languageCode);
    // sharedPreferences.setString('country_code', locale.countryCode!);
  }
}