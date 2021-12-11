import 'package:flutter/material.dart';

const Color kRichWhite = Color(0xFFFFFFFF);
const Color kRichBlack = Color(0xFF000000);
const Color kOxfordBlue = Color(0xFF001D3D);
const Color kPrussianBlue = Color(0xFF003566);
const Color kMikadoOrange = Color(0xFFFB681E);
const Color kLightOrange = Color(0xFFFFB38D);
const Color kDavysGrey = Color(0xFF4B5358);
const Color kRed = Color(0xFFDF4759);
const Color kGrey = Color(0xFF727272);
const Color kLightGrey = Color(0xFFB6B6B6);
const Color kLightGrey2 = Color(0xFFEAEAEA);

final LinearGradient kLinearGradient = LinearGradient(
  colors: [kMikadoOrange.withOpacity(0.0), kMikadoOrange],
  stops: const [
    0.1,
    0.90,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient kLinearGradient2 = LinearGradient(
  colors: [kMikadoOrange, kMikadoOrange.withOpacity(0.0)],
  stops: const [
    0.1,
    0.90,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const kColorScheme = ColorScheme(
  primary: kMikadoOrange,
  primaryVariant: kMikadoOrange,
  secondary: kPrussianBlue,
  secondaryVariant: kPrussianBlue,
  surface: kRichBlack,
  background: kRichWhite,
  error: kRed,
  onPrimary: kMikadoOrange,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);
