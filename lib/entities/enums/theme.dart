// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckpointColor {
  static const Color primary = _Primitive.purple400;
  static const Color lightPrimary = _Primitive.purple200;
  static const Color deepPrimary = _Primitive.purple700;

  static const Color danger = _Primitive.red500;

  static const Color secondary = _Primitive.lavender200;

  static const Color neutral = _Primitive.grey700;
  static const Color lightNeutral = _Primitive.grey500;
  static const Color deepNeutral = _Primitive.grey900;

  static const Color background = _Primitive.grey950;
  static const Color backgroundElevated = _Primitive.grey900;
  static const Color foreground = _Primitive.grey0;

  static const Color divider = _Primitive.grey700alpha50;
  static const Color appBarBorder = _Primitive.lavender400alpha25;

  static const Color buttonPrimaryBG = primary;
  static const Color buttonPrimaryFG = foreground;
  static const Color buttonPrimaryPressedBG = deepPrimary;
  static const Color buttonPrimaryPressedFG = foreground;
  static const Color buttonPrimaryDisabledBG = _Primitive.purple800;
  static const Color buttonPrimaryDisabledFG = neutral;

  static const Color buttonSecondaryBG = deepNeutral;
  static const Color buttonSecondaryFG = foreground;
  static const Color buttonSecondaryPressedBG = _Primitive.purple800;
  static const Color buttonSecondaryPressedFG = _Primitive.grey100;
  static const Color buttonSecondaryDisabledBG = deepNeutral;
  static const Color buttonSecondaryDisabledFG = _Primitive.grey800;

  static const Color buttonDangerBG = _Primitive.red400;
  static const Color buttonDangerFG = foreground;
  static const Color buttonDangerPressedBG = _Primitive.red300;
  static const Color buttonDangerPressedFG = foreground;
  static const Color buttonDangerDisabledBG = _Primitive.red600;
  static const Color buttonDangerDisabledFG = neutral;
}

class CheckpointStyle {
  static const TextStyle _base = TextStyle(
    color: CheckpointColor.foreground,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle title = _base.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle subtitle = _base.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bodyLarge = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle body = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle label = _base.copyWith(fontSize: 14);

  static final TextStyle labelNeutral = _base.copyWith(
    fontSize: 14,
    color: CheckpointColor.neutral,
  );

  static final TextStyle labelHighlight = _base.copyWith(
    fontSize: 14,
    color: CheckpointColor.primary,
  );

  static final TextStyle caption = _base.copyWith(fontSize: 12);

  static final TextStyle captionNeutral = _base.copyWith(
    fontSize: 12,
    color: CheckpointColor.neutral,
  );

  static TextStyle labelMonospace = GoogleFonts.robotoMono(
    color: CheckpointColor.foreground,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle titleMonospace = GoogleFonts.robotoMono(
    color: CheckpointColor.foreground,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static TextStyle labelLarge = GoogleFonts.robotoMono(
    color: CheckpointColor.foreground,
    fontSize: 48,
    fontWeight: FontWeight.w400,
  );

  static final ButtonStyle buttonPrimary = TextButton.styleFrom(
    backgroundColor: CheckpointColor.buttonPrimaryBG,
    foregroundColor: CheckpointColor.buttonPrimaryFG,
    disabledBackgroundColor: CheckpointColor.buttonPrimaryDisabledBG,
    disabledForegroundColor: CheckpointColor.buttonPrimaryDisabledFG,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
  );

  static final ButtonStyle buttonSecondary = TextButton.styleFrom(
    backgroundColor: CheckpointColor.buttonSecondaryBG,
    foregroundColor: CheckpointColor.buttonSecondaryFG,
    disabledBackgroundColor: CheckpointColor.buttonSecondaryDisabledBG,
    disabledForegroundColor: CheckpointColor.buttonSecondaryDisabledFG,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
  );

  static final ButtonStyle buttonDanger = TextButton.styleFrom(
    backgroundColor: CheckpointColor.buttonDangerBG,
    foregroundColor: CheckpointColor.buttonDangerFG,
    disabledBackgroundColor: CheckpointColor.buttonDangerDisabledBG,
    disabledForegroundColor: CheckpointColor.buttonDangerDisabledFG,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
  );
}

class CheckpointTheme {
  static const AppBarTheme appBarTheme = AppBarTheme(
    iconTheme: IconThemeData(color: CheckpointColor.foreground),
    actionsPadding: EdgeInsets.only(right: 20),
    backgroundColor: CheckpointColor.backgroundElevated,
    centerTitle: true,
  );

  static ThemeData appTheme = ThemeData(
    appBarTheme: appBarTheme,
    textTheme: GoogleFonts.interTextTheme(),
    scaffoldBackgroundColor: CheckpointColor.background,
    primaryColor: CheckpointColor.primary,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: CheckpointColor.primary,
      selectionColor: CheckpointColor.lightPrimary,
      selectionHandleColor: CheckpointColor.primary,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: CheckpointColor.backgroundElevated,
      surfaceTintColor: CheckpointColor.primary,
      confirmButtonStyle: CheckpointStyle.buttonPrimary,
    ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: CheckpointColor.divider,
    ),
  );
}

class _Primitive {
  static const Color grey0 = Color(0xFFFFFFFF);
  static const Color grey100 = Color(0xFFEBEDEF);
  static const Color grey200 = Color(0xFFDDE1E4);
  static const Color grey300 = Color(0xFFCED3D8);
  static const Color grey400 = Color(0xFFBDC4CB);
  static const Color grey500 = Color(0xFFAAB4BC);
  static const Color grey600 = Color(0xFF95A1AC);
  static const Color grey700 = Color(0xFF808A93);
  static const Color grey700alpha50 = Color(0x7F808A93);
  static const Color grey800 = Color(0xFF606169);
  static const Color grey900 = Color(0xFF2B2B2B);
  static const Color grey950 = Color(0xFF191A1F);
  static const Color grey1000 = Color(0xFF000000);

  static const Color purple100 = Color(0xFFB6A4FF);
  static const Color purple200 = Color(0xFFA792FF);
  static const Color purple300 = Color(0xFF9980FF);
  static const Color purple400 = Color(0xFF7C5BFF);
  static const Color purple500 = Color(0xFF6D49FF);
  static const Color purple600 = Color(0xFF6242E6);
  static const Color purple700 = Color(0xFF573ACC);
  static const Color purple800 = Color(0xFF341E90);

  static const Color lavender100 = Color(0xFFF1EDFF);
  static const Color lavender200 = Color(0xFFE9E4FE);
  static const Color lavender300 = Color(0xFFE2DBFE);
  static const Color lavender400 = Color(0xFFDBD2FE);
  static const Color lavender400alpha25 = Color(0x40DBD2FE);
  static const Color lavender500 = Color(0xFFC5BDE5);
  static const Color lavender600 = Color(0xFFAFA8CB);
  static const Color lavender700 = Color(0xFF9993B2);

  static const Color red100 = Color(0xFFFAB5B5);
  static const Color red200 = Color(0xFFF89191);
  static const Color red300 = Color(0xFFF56C6C);
  static const Color red400 = Color(0xFFF34747);
  static const Color red500 = Color(0xFFDB4040);
  static const Color red600 = Color(0xFFAA3232);
  static const Color red700 = Color(0xFF7A2424);

  static const Color yellow100 = Color(0xFFF8F4CC);
  static const Color yellow200 = Color(0xFFF5EB78);
  static const Color yellow300 = Color(0xFFE6D513);
  static const Color yellow400 = Color(0xFFD9850E);
  static const Color yellow500 = Color(0xFFDA7202);
  static const Color yellow600 = Color(0xFFC46702);
  static const Color yellow700 = Color(0xFFAE5B02);

  static const Color green100 = Color(0xFFA7E8AB);
  static const Color green200 = Color(0xFF7CDC80);
  static const Color green300 = Color(0xFF50D156);
  static const Color green400 = Color(0xFF24C52C);
  static const Color green500 = Color(0xFF20B128);
  static const Color green600 = Color(0xFF1D9E23);
  static const Color green700 = Color(0xFF16761A);
}
