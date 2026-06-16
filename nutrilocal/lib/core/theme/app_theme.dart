import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme =
      ThemeData(

    brightness:
        Brightness.light,

    fontFamily:
        'Poppins',

    scaffoldBackgroundColor:
        const Color(
            0xFFF8FAFC),

    splashColor:
        Colors.transparent,

    highlightColor:
        Colors.transparent,

    appBarTheme:
        const AppBarTheme(

      elevation: 0,

      backgroundColor:
          Colors.transparent,

      centerTitle: false,
    ),

    colorScheme:
        const ColorScheme.light(

      primary:
          Color(0xFF7C3AED),

      secondary:
          Color(0xFF06B6D4),

      surface:
          Colors.white,

      onSurface:
          Colors.black87,
    ),

    textTheme:
        const TextTheme(

      headlineLarge:
          TextStyle(

        fontSize: 42,

        fontWeight:
            FontWeight.bold,

        color:
            Colors.black87,
      ),

      headlineMedium:
          TextStyle(

        fontSize: 32,

        fontWeight:
            FontWeight.bold,

        color:
            Colors.black87,
      ),

      titleLarge:
          TextStyle(

        fontSize: 24,

        fontWeight:
            FontWeight.bold,

        color:
            Colors.black87,
      ),

      bodyLarge:
          TextStyle(

        fontSize: 18,

        color:
            Colors.black87,
      ),

      bodyMedium:
          TextStyle(

        fontSize: 15,

        color:
            Colors.black54,
      ),
    ),
  );

  static ThemeData darkTheme =
      ThemeData(

    brightness:
        Brightness.dark,

    fontFamily:
        'Poppins',

    scaffoldBackgroundColor:
        const Color(
            0xFF020617),

    splashColor:
        Colors.transparent,

    highlightColor:
        Colors.transparent,

    appBarTheme:
        const AppBarTheme(

      elevation: 0,

      backgroundColor:
          Colors.transparent,

      centerTitle: false,
    ),

    colorScheme:
        const ColorScheme.dark(

      primary:
          Color(0xFF7C3AED),

      secondary:
          Color(0xFF06B6D4),

      surface:
          Color(0xFF111827),

      onSurface:
          Colors.white,
    ),

    textTheme:
        const TextTheme(

      headlineLarge:
          TextStyle(

        fontSize: 42,

        fontWeight:
            FontWeight.bold,

        color:
            Colors.white,
      ),

      headlineMedium:
          TextStyle(

        fontSize: 32,

        fontWeight:
            FontWeight.bold,

        color:
            Colors.white,
      ),

      titleLarge:
          TextStyle(

        fontSize: 24,

        fontWeight:
            FontWeight.bold,

        color:
            Colors.white,
      ),

      bodyLarge:
          TextStyle(

        fontSize: 18,

        color:
            Colors.white,
      ),

      bodyMedium:
          TextStyle(

        fontSize: 15,

        color:
            Colors.white70,
      ),
    ),
  );
}