import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e_commerce_app/themes/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import 'light_color.dart';

class AppTheme {
  const AppTheme();

  static InputDecoration inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding, vertical: kDefaultRadius * 0.8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDefaultRadius * 0.75),
      borderSide: const BorderSide(color: LightColor.kPrimaryColor, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDefaultRadius * 0.75),
      borderSide: const BorderSide(color: LightColor.kPrimaryColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDefaultRadius * 0.75),
      borderSide: const BorderSide(color: LightColor.kPrimaryColor, width: 1.5),
    ),
  );

  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
    backgroundColor: LightColor.kPrimaryColor,
    //elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kDefaultRadius * 0.75),
    ),
  );

  static ThemeData theme = ThemeData(
    textTheme: GoogleFonts.mulishTextTheme(),
    primaryColorDark: const Color(0xFF0097A7),
    // primaryColorLight: const Color(0xFFB2EBF2),
    //primarySwatch: Colors.blue,
    primaryColor: LightColor.kPrimaryColor,
    //colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
    inputDecorationTheme: const InputDecorationTheme(
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(30),
      // ),

      prefixIconColor: LightColor.kPrimaryColor,
    ),

    scaffoldBackgroundColor: LightColor.bgColor,
    //primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      // color: const Color(0xFF000000),
      iconTheme: IconThemeData(color: Colors.black),
      toolbarHeight: 45,
    ),
  );

  static List<BoxShadow> shadow = <BoxShadow>[
    const BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
