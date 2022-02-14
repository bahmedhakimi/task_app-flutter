// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_app/theme/color/colors.dart';

// ignore: prefer_typing_uninitialized_variables
class Snackbar {
  snackbar(String title, String message) {
    return Get.snackbar(title, message,
        backgroundColor: AppColors.kBlue,
        icon: const Icon(
          Icons.warning_amber_rounded ,
          color: Colors.white,
        ),
        colorText: AppColors.kLightYellow2,
        animationDuration: const Duration(milliseconds: 900));
  }
/* 
  showBar(context, message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black87),
      ),
      backgroundColor: Colors.tealAccent,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      elevation: 20,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } */
}
