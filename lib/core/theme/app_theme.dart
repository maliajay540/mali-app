import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
        color: Color(0xFF1B1E28),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
        letterSpacing: 0.2,
      ),
    ),
  );
}