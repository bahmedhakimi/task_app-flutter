// ignore_for_file: use_key_in_widget_constructors, camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_app/theme/color/colors.dart';
import 'package:to_app/ui/size_config.dart';

class Select_Date_Bar extends StatelessWidget {
  final Function fun;
  final String text;
  final DateTime selectedDate;
  const Select_Date_Bar({
    required this.fun,
    required this.text,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
            height: SizeConfig.screenHeight * 0.08,
            margin: EdgeInsets.only(left: 5, bottom: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kDarkYellow,
            ),
            child: Center(
              child: InkWell(
                child: Image(
                  image: AssetImage('images/date.png'),
                ),
                onTap: () => fun(),
              ),
            )),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 3),
            height: SizeConfig.screenHeight * 0.07,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      selectedDate.toString().split(' ')[0],
                      style: const TextStyle(
                        color: AppColors.kDarkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
