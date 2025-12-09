part of 'core.dart';

class AppTheme {
  static double headlineLarge = 24.0;
  static double headlineMedium = 20.0;
  static double headlineSmall = 18.0;
  static double bodyLarge = 16.0;
  static double bodyMedium = 14.0;
  static double bodySmall = 12.0;
  static double labelLarge = 16.0;
  static double labelMedium = 14.0;
  static double labelSmall = 12.0;

  static OutlineInputBorder paindreOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(borderSide: BorderSide(width: 1.5, style: BorderStyle.solid, color: color), borderRadius: BorderRadius.circular(10));
  }

  ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[900]!),
    fontFamily: GoogleFonts.openSans().fontFamily,
    appBarTheme: AppBarTheme(backgroundColor: Colors.blue[900]!, iconTheme: const IconThemeData(color: Colors.white)),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily, fontSize: headlineLarge, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily, fontSize: headlineMedium, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily, fontSize: headlineSmall, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily, fontSize: bodyLarge, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily, fontSize: bodyMedium, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily, fontSize: bodySmall, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily, fontSize: labelLarge, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily, fontSize: labelMedium, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily, fontSize: labelSmall, fontWeight: FontWeight.w400),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      hintStyle: TextStyle(fontSize: bodyMedium, color: Colors.grey[600]),
      labelStyle: TextStyle(fontSize: bodyLarge, color: Colors.black),
      errorStyle: TextStyle(fontSize: bodySmall, color: const Color.fromARGB(255, 255, 24, 24)),
      focusedBorder: paindreOutlineInputBorder(color: Colors.blue[900]!),
      enabledBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 31, 30, 30)),
      disabledBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 216, 216, 216)),
      focusedErrorBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 255, 24, 24)),
      errorBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 255, 24, 24)),
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: bodyMedium, color: Colors.grey[600]),
        labelStyle: TextStyle(fontSize: bodyLarge, color: Colors.black),
        errorStyle: TextStyle(fontSize: bodySmall, color: const Color.fromARGB(255, 255, 24, 24)),
        focusedBorder: paindreOutlineInputBorder(color: Colors.blue[900]!),
        enabledBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 31, 30, 30)),
        disabledBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 216, 216, 216)),
        focusedErrorBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 255, 24, 24)),
        errorBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 255, 24, 24)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey[900]!; // Warna saat tombol dinonaktifkan
          }
          if (states.contains(WidgetState.pressed)) {
            return Colors.blue[800]!; // Warna saat tombol ditekan
          }
          if (states.contains(WidgetState.hovered)) {
            return Colors.blue[800]!; // Warna saat tombol dihover
          }
          if (states.contains(WidgetState.focused)) {
            return Colors.blue[600]!; // Warna saat tombol difokuskan
          }
          if (states.contains(WidgetState.selected)) {
            return Colors.blue[900]!; // Warna saat tombol dipilih
          }
          if (states.contains(WidgetState.error)) {
            return Colors.red; // Warna saat tombol dalam keadaan error
          }
          return Colors.blue[800]!;
        }),
        textStyle: WidgetStateProperty.all(
          TextStyle(color: Colors.black, fontSize: labelMedium, fontWeight: FontWeight.w600, fontFamily: GoogleFonts.kanit().fontFamily),
        ),
      ),
    ),
  );
}
