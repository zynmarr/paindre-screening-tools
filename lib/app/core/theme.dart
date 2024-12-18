part of 'core.dart';

class AppTheme {
  static OutlineInputBorder paindreOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        style: BorderStyle.solid,
        color: color,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue[900]!,
      background: Colors.grey[200]!,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[900]!,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    // dropdownMenuTheme: DropdownMenuThemeData(
    //   menuStyle: MenuStyle(
    //     backgroundColor: MaterialStatePropertyAll(Colors.white),
    //     surfaceTintColor: MaterialStatePropertyAll(Colors.white),
    //     shadowColor: MaterialStatePropertyAll(Colors.white),
    //   ),
    // ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      // hintStyle: TextStyle(
      //   fontSize: bodySize,
      // ),
      // helperStyle: const TextStyle(
      //   fontSize: 14,
      // ),
      // errorStyle: const TextStyle(
      //   fontSize: 14,
      // ),
      focusedBorder: paindreOutlineInputBorder(color: Colors.blue[900]!),
      enabledBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 255, 255, 255)),
      disabledBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 216, 216, 216)),
      focusedErrorBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 255, 24, 24)),
      errorBorder: paindreOutlineInputBorder(color: const Color.fromARGB(255, 255, 24, 24)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(Colors.blue[800]!),
      ),
    ),
  );
}
