import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_app/theme/color/colors.dart';





class Themes {
  static final light = ThemeData(
      primaryColor: AppColors.primaryClr,
      backgroundColor: AppColors.primaryClr,
      brightness: Brightness.light);
  static final dark = ThemeData(
      primaryColor: AppColors.white,
      backgroundColor: AppColors.white,
      brightness: Brightness.dark);

  TextStyle get headinstyle {
    return GoogleFonts.aBeeZee(
        textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black));
  }
  TextStyle get subheadinstyle {
    return GoogleFonts.aBeeZee(
        textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black87));
  }
    TextStyle get titestyle {
    return GoogleFonts.aBeeZee(
        textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black));
  }
   TextStyle get subtitestyle {
    return GoogleFonts.aBeeZee(
        textStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Get.isDarkMode ? Colors.white : Colors.black87));
  }
    TextStyle get bodystyle {
    return GoogleFonts.aBeeZee(
        textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Get.isDarkMode ? Colors.white : Colors.black));
  }

}
