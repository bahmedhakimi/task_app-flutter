// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:to_app/theme/color/colors.dart';
import 'package:to_app/theme/theme.dart';
import 'package:to_app/ui/size_config.dart';

class Person_Info extends StatelessWidget {
  final task_Controller;
  const Person_Info({required this.task_Controller}) ;

  @override
  Widget build(BuildContext context) {
    
    return Container(
                height: SizeConfig.screenHeight * 0.15,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.kDarkYellow,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0),
                    )),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularPercentIndicator(
                              radius: 40,
                              lineWidth: 5.0,
                              animation: true,
                              percent: 0.75,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: AppColors.kRed,
                              backgroundColor: AppColors.kDarkYellow,
                              center: const CircleAvatar(
                                backgroundColor: AppColors.kBlue,
                                radius: 35.0,
                                backgroundImage: AssetImage(
                                  'images/person.jpeg',
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Obx(() {
                                  return Column(
                                    children: [
                                      Text(
                                        'Welecome',
                                        textAlign: TextAlign.start,
                                        style: Themes().titestyle,
                                      ),
                                      Text('${task_Controller.name}',
                                          textAlign: TextAlign.start,
                                          style: Themes().subtitestyle),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ]),
                    ]),
              );
  }
}