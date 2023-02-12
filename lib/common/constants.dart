import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';

// colors
const Color kRichBlack = Color.fromARGB(255, 14, 68, 150);
const Color kOxfordBlue = Color(0xFF001D3D);
const Color kPrussianBlue = Color.fromARGB(255, 56, 123, 185);
const Color kMikadoYellow = Color.fromARGB(255, 189, 161, 80);
const Color kDavysGrey = Color.fromARGB(255, 65, 69, 71);
const Color kGrey = Color(0xFF303030);

// text style
final TextStyle kHeading5 =
    GoogleFonts.amarante(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.amarante(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.amarante(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.amarante(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);

// text theme
final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);

const kColorScheme = ColorScheme(
  primary: kMikadoYellow,
  primaryContainer: kMikadoYellow,
  secondary: kPrussianBlue,
  secondaryContainer: kPrussianBlue,
  surface: kRichBlack,
  background: kRichBlack,
  error: Colors.red,
  onPrimary: kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
