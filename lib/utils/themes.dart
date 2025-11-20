
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes{
  static final ThemeData temaEscuro = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue[900],

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.dark,
    ),

    textTheme: TextTheme(
      displayMedium: GoogleFonts.domine(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.deepPurple[700],
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple[700],
      foregroundColor: Colors.black,
      titleTextStyle: GoogleFonts.cherryBombOne(
        fontSize: 32,
        color: Colors.white,
      ),
      elevation: 2,
    )

  );
}