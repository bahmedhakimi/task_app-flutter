// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_app/models/task.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:to_app/theme/color/colors.dart';

import '../size_config.dart';
import '../../theme/theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task);
  final Task task;
  @override
  Widget build(BuildContext context) {
    /* horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20) */
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              getcolor(task.color).shade300,
              getcolor(task.color).shade500,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
              topRight: Radius.circular(25),
              topLeft: Radius.circular(12)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0.9,
              child: Text(
                '${task.startTime.toString().split(' ')[0]}\n${task.startTime.toString().split(' ')[1]}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(task.title, style: Themes().headinstyle),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      Text(task.note, style: Themes().subtitestyle)
                    ],
                  ),
                )),
                Container(
                  alignment: Alignment.center,
                  child: CircularPercentIndicator(
                    animation: true,
                    radius: 50,
                    percent: task.isCompleted == '0' ? 0.6 : 1,
                    lineWidth: 4.0,
                    backgroundColor: Colors.white54,
                    circularStrokeCap: CircularStrokeCap.square,
                    progressColor: getcolor(task.color).shade700,
                    center: Text(
                      task.isCompleted == '0' ? 'TO DO' : 'Completed',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getcolor(String? color) {
    switch (color) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'blue':
        return Colors.blue;
      default:
        AppColors.primaryClr;
    }
  }
}
