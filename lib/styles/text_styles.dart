import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// text style
final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);
final TextStyle kCaptionText = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.25);
final TextStyle kButton = GoogleFonts.poppins(
    fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.25);
final TextStyle kOverline = GoogleFonts.poppins(
    fontSize: 10, fontWeight: FontWeight.w300, letterSpacing: 0.25);

// text theme
final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
  caption: kCaptionText,
  button: kButton,
  overline: kOverline,
);
