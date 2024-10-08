import 'package:flutter/material.dart';

const mediumTextSize = 14.0;
const smallTextSize = mediumTextSize * 0.8;
const largeTextSize = mediumTextSize * 1.1;

const defaultPadding = 5.0;
const borderDefaultPadding = 20.0;
const defaultRadius = 10.0;

const cAppBarColor = Color(0xFFBFD8FB);
const cBottomBarColor = cAppBarColor;
const cButtonBgColor = Colors.white;
const cButtonBgHoverColor = Colors.white70;
const cButtonTextColor = Colors.black;
const cButtonTextHoverColor = Color(0xFFBFD8FB);
const cButtonBorderColor = Color(0xFF8FB4E7);
const cButtonBorderHoverColor = Color(0xFF8FB4E7);
const cBoxBorderColor = Colors.black12;

enum ButtonType {
  normal,
  success,
  danger,
  warning,
  discard,
}

// const primaryColor = Color(0xFF00AF80);
const kPrimaryColor = Colors.blue;
const kSecondaryColor = Color(0xFFE66A38);
const kContentColor = Colors.white;
const kScaffoldBgColor = Color(0xFFE7ECF9);
const kBgColor = Colors.white;
const kBgColorHeader = Color.fromARGB(255, 53, 122, 190);
const kBgColorRow1 = Color(0xFFC7E3FF);
const kGgColorRow2 = Color(0xFFC7D1FF);
const kButtonBgColor1 = Colors.grey;
const kButtonPressedBgColor = Color(0xFFC65326);
const kCardColor = Colors.white;
const kTextColor = Colors.black;
const kErrorColor = Color(0xFFC70D00);
const kBorderColor = Colors.black12;

// const darkPrimaryColor = Color(0xFF00AF80);
const kDarkPrimaryColor = Color(0xFF3D93DA);
const kDarkSecondaryColor = Color(0xFFE66A38);
const kDarkContentColor = Colors.white;
const kDarkScaffoldBgColor = Color(0xFF36373A);
const kDarkBgColor = Color(0xFF4A4B4F);
const kDarkCardColor = Color(0xFF4A4B4F);
const kDarkTextColor = Colors.white;
const kDarkErrorColor = Colors.red;

class MaterialColorGenerator {
  static MaterialColor from(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}

// const defaultBorder = null;
// const defaultFocusedBorder = null;
const kBorder = UnderlineInputBorder(
    borderSide: BorderSide(width: 1, color: kPrimaryColor));

const kFocusedBorder = UnderlineInputBorder(
    borderSide: BorderSide(width: 1, color: kPrimaryColor));

const kDisabledBorder = UnderlineInputBorder(
    borderSide: BorderSide(width: 1, color: kPrimaryColor));

final lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    color: cAppBarColor,
    elevation: 0,
  ),
  scaffoldBackgroundColor: kScaffoldBgColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: MaterialColorGenerator.from(kPrimaryColor),
    accentColor: kPrimaryColor,
    backgroundColor: kBgColor,
    cardColor: kCardColor,
    errorColor: kErrorColor,
  ).copyWith(secondary: kSecondaryColor),
  fontFamily: 'NotoSans',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: largeTextSize),
    displayMedium: TextStyle(fontSize: mediumTextSize),
    displaySmall: TextStyle(fontSize: smallTextSize),
    titleLarge: TextStyle(fontSize: largeTextSize),
    titleMedium: TextStyle(fontSize: mediumTextSize),
    titleSmall: TextStyle(fontSize: smallTextSize),
    bodyLarge: TextStyle(fontSize: mediumTextSize),
    bodyMedium: TextStyle(fontSize: mediumTextSize),
    bodySmall: TextStyle(fontSize: smallTextSize),
    labelLarge: TextStyle(fontSize: mediumTextSize),
    labelMedium: TextStyle(fontSize: mediumTextSize),
    labelSmall: TextStyle(fontSize: smallTextSize),
    headlineLarge: TextStyle(fontSize: largeTextSize * 1.5),
    headlineMedium: TextStyle(fontSize: mediumTextSize * 1.5),
    headlineSmall: TextStyle(fontSize: smallTextSize * 1.5),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: kDarkScaffoldBgColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: MaterialColorGenerator.from(kDarkPrimaryColor),
    brightness: Brightness.dark,
    accentColor: kDarkPrimaryColor,
    backgroundColor: kDarkBgColor,
    cardColor: kDarkCardColor,
    errorColor: kDarkErrorColor,
  ).copyWith(secondary: kDarkSecondaryColor),
  fontFamily: 'NotoSans',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: largeTextSize),
    displayMedium: TextStyle(fontSize: mediumTextSize),
    displaySmall: TextStyle(fontSize: smallTextSize),
    titleLarge: TextStyle(fontSize: largeTextSize),
    titleMedium: TextStyle(fontSize: mediumTextSize),
    titleSmall: TextStyle(fontSize: smallTextSize),
    bodyLarge: TextStyle(fontSize: mediumTextSize),
    bodyMedium: TextStyle(fontSize: mediumTextSize),
    bodySmall: TextStyle(fontSize: smallTextSize),
    labelLarge: TextStyle(fontSize: mediumTextSize),
    labelMedium: TextStyle(fontSize: mediumTextSize),
    labelSmall: TextStyle(fontSize: smallTextSize),
    headlineLarge: TextStyle(fontSize: largeTextSize * 1.5),
    headlineMedium: TextStyle(fontSize: mediumTextSize * 1.5),
    headlineSmall: TextStyle(fontSize: smallTextSize * 1.5),
  ),
);

// TextStyle kLoginTitleStyle(Size size) => GoogleFonts.ubuntu(
//       fontSize: size.height * 0.060,
//       fontWeight: FontWeight.bold,
//     );

// TextStyle kLoginSubtitleStyle(Size size) => GoogleFonts.ubuntu(
//       fontSize: size.height * 0.030,
//     );

// TextStyle kLoginTermsAndPrivacyStyle(Size size) =>
//     GoogleFonts.ubuntu(fontSize: 15, color: Colors.grey, height: 1.5);

// TextStyle kHaveAnAccountStyle(Size size) =>
//     GoogleFonts.ubuntu(fontSize: size.height * 0.022, color: Colors.black);

// TextStyle kLoginOrSignUpTextStyle(
//   Size size,
// ) =>
//     GoogleFonts.ubuntu(
//       fontSize: size.height * 0.022,
//       fontWeight: FontWeight.w500,
//       color: Colors.deepPurpleAccent,
//     );

TextStyle kTextFormFieldStyle() => const TextStyle(color: Colors.black);
