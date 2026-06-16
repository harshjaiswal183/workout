import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryTeal = Color(0xFF00E5FF);
  static const Color primaryPurple = Color(0xFF7C4DFF);
  static const Color accentPink = Color(0xFFFF4081);
  
  static const Color darkBackground = Color(0xFF0D0B18);
  static const Color darkCard = Color(0xFF1A162E);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA099C0);

  static const Color lightBackground = Color(0xFFF5F6FA);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1A1A24);
  static const Color lightTextSecondary = Color(0xFF6A6A80);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryTeal, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFFFA726), Color(0xFFFB8C00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [Color(0xFFEC407A), Color(0xFFD81B60)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF29B6F6), Color(0xFF0288D1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF66BB6A), Color(0xFF43A047)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: lightBackground,
      cardTheme: CardThemeData(
        color: lightCard,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: lightText),
        titleTextStyle: TextStyle(
          color: lightText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: primaryPurple,
        secondary: primaryTeal,
        background: lightBackground,
        surface: lightCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: lightText, letterSpacing: -0.5),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: lightText),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: lightText),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: lightText),
        bodyLarge: TextStyle(fontSize: 16, color: lightText),
        bodyMedium: TextStyle(fontSize: 14, color: lightTextSecondary),
      ),
    );
  }

  // Dark Theme Configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryTeal,
      scaffoldBackgroundColor: darkBackground,
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: Colors.white.withOpacity(0.04), width: 1.2),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkText),
        titleTextStyle: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: primaryTeal,
        secondary: primaryPurple,
        background: darkBackground,
        surface: darkCard,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: darkText, letterSpacing: -0.5),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkText),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkText),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText),
        bodyLarge: TextStyle(fontSize: 16, color: darkText),
        bodyMedium: TextStyle(fontSize: 14, color: darkTextSecondary),
      ),
    );
  }
}
