import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static const Color cyberGreen = Color(AppConstants.cyberGreenValue);
  static const Color cyberBlack = Color(AppConstants.cyberBlackValue);
  static const Color cyberDark = Color(AppConstants.cyberDarkValue);
  static const Color cyberBlue = Color(AppConstants.cyberBlueValue);
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: cyberGreen,
      scaffoldBackgroundColor: cyberBlack,
      colorScheme: const ColorScheme.dark(
        primary: cyberGreen,
        secondary: cyberGreen,
        surface: cyberDark,
        error: Colors.red,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.orbitron(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        displayMedium: GoogleFonts.orbitron(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: cyberGreen,
        ),
        displaySmall: GoogleFonts.orbitron(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: cyberGreen,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      // Note: Using explicit font family references in widgets
    );
  }
}

