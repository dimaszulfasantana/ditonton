import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';

// colors
const Color colourNavy = Color.fromARGB(255, 14, 68, 150);
const Color colourDarkBlue = Color.fromARGB(255, 1, 25, 51);
const Color colourBlueLight = Color.fromARGB(255, 56, 123, 185);
const Color colourDarkYellow = Color.fromARGB(255, 189, 161, 80);
const Color colourDarkGrey = Color.fromARGB(255, 65, 69, 71);
const Color colourDarkerGrey = Color.fromARGB(255, 51, 51, 51);

// text style
final TextStyle headlineBig =
    GoogleFonts.amarante(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle headLineBigger = GoogleFonts.amarante(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle subtitleMedium = GoogleFonts.amarante(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle subtitleBodyMedium = GoogleFonts.amarante(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);

// text theme
final kTextTheme = TextTheme(
  headlineSmall: headlineBig,
  titleLarge: headLineBigger,
  titleMedium: subtitleMedium,
  bodyMedium: subtitleBodyMedium,
);

const kColorScheme = ColorScheme(
  primary: colourDarkYellow,
  primaryContainer: colourDarkYellow,
  secondary: colourBlueLight,
  secondaryContainer: colourBlueLight,
  surface: colourNavy,
  background: colourNavy,
  error: Colors.red,
  onPrimary: colourNavy,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
