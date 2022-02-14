// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:to_app/theme/color/colors.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function ontap;
  const MyButton({required this.label, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => ontap(),
        child: Container(
          margin: const EdgeInsets.all(5),
          width: 100,
          height: 45,
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.kLightYellow2, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.kGreen,
          ),
        ));
  }
}
