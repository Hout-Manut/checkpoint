import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


ThemeData themeData = ThemeData(textTheme: GoogleFonts.interTextTheme());

//
//  Define Color App
//
class CheckpointColors {
  static const Color primary = const Color(0xFF7C5BFF);
  static const Color deepPrimary = const Color(0xFF573ACC);
  static const Color lightPrimary = const Color(0xFFA792FF);
  static const Color secondary = const Color(0xFFDBD2FE);
  static const Color foreground = const Color(0xFFFFFFFF);
  static const Color deepBackground = const Color(0xFF000000);
  static const Color deepNeutral = const Color(0xFF2B2B2B);
  static const Color neutral = const Color(0xFF808A93);
  static const Color background = const Color(0xFF191A1F);

  static const Color buttonPrimaryBg = primary;
  static const Color buttonPrimaryFg = foreground;

  static const Color buttonSecondaryBg =deepNeutral;
  static const Color buttonSecondaryFg =foreground;

  static const Color buttonDangerBg=  Color(0xFFF34747);
  static const Color buttonDangerFg=  foreground;
}

//
// Definition of App text styles.
//
class CheckpointTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  static const TextStyle subTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
}

// Component Values

//
// Define app spacings, in pixel
// Include extra small(xs), small(s), medium(m), large(l), exta large(xl)
//
class CheckpointSpacings {
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16;
  static const double l = 20;
  static const double xl = 24;
  static const double xll = 32;

  static const double cornerRadiusSmall = 7;
  static const double cornerRadiusMedium = 10;
  static const double cornerRadiusLarge = 15;
}
