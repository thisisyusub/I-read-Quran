import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './colors.dart';

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  textTheme: TextTheme(
    bodyText1: GoogleFonts.robotoCondensed(
      fontSize: 16,
      letterSpacing: 0,
    ),
    subtitle2: GoogleFonts.robotoCondensed(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
    ),
    headline6: GoogleFonts.robotoCondensed(
      fontSize: 22,
      letterSpacing: 0,
    ),
    bodyText2: GoogleFonts.robotoCondensed(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
    ),
    caption: GoogleFonts.robotoCondensed(
      fontSize: 12,
      letterSpacing: 0,
      fontStyle: FontStyle.italic,
    ),
  ),
);
