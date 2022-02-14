// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_app/models/task.dart';
import 'package:to_app/theme/color/colors.dart';
import 'package:to_app/theme/theme.dart';
import 'package:to_app/ui/size_config.dart';

class Task_State extends StatelessWidget {
  final selected_date;
  final task_Controller;
  const Task_State({required this.selected_date, required this.task_Controller});

  @override
  Widget build(BuildContext context) {
    int to_do = 0;

    indecator_lenght() {
      int index = 0, ind_lenght = 0;
      while (index < task_Controller.tasklist.length) {
        Task task = task_Controller.tasklist[index];
        if (task.repeat == 'Daily' ||
            task.date == DateFormat.yMd().format(selected_date) ||
            (task.repeat == 'Weekly' &&
                (selected_date
                            .difference(DateFormat.yMd().parse(task.date))
                            .inDays %
                        7 ==
                    0)) ||
            (task.repeat == 'Monthly' &&
                (DateFormat.yMd().parse(task.date).day == selected_date.day))) {
          ind_lenght++;
        }
        index++;
      }
      return ind_lenght;
    }

    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: SizeConfig.screenHeight * 0.2,
        width: double.infinity,
        child: SizedBox(child: Obx(() {
          if (task_Controller.taskstatelist.isNotEmpty) {
            to_do = indecator_lenght();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Row -----------------------1 TO DO && inprogress
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: SizeConfig.screenHeight * 0.06,
                            height: SizeConfig.screenHeight * 0.06,
                            child: const Icon(
                              Icons.alarm,
                              color: Colors.white,
                              size: 30,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.kRed,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenHeight * 0.01,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To Do',
                                style: Themes().titestyle,
                              ),
                              Text(
                                '$to_do${to_do <= 1 ? ' Task.' : ' Tasks'}',
                                style: Themes().bodystyle,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      //Row ***********************  in progress
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: SizeConfig.screenHeight * 0.06,
                            height: SizeConfig.screenHeight * 0.06,
                            child: const Icon(
                              Icons.av_timer_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.kGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenHeight * 0.01,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'In Progress',
                                style: Themes().titestyle,
                              ),
                              Text(
                                ' ${task_Controller.taskstatelist[0].inprogress}'
                                '${(task_Controller.taskstatelist[0].inprogress <= 0) ? ' Task.' : ' Tasks.'}',
                                style: Themes().bodystyle,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                  ),

                  //Row ************************** Done
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: SizeConfig.screenHeight * 0.06,
                        height: SizeConfig.screenHeight * 0.06,
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 30,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.kBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.screenHeight * 0.01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Done',
                            style: Themes().titestyle,
                          ),
                          Text(
                            //${task_Controller.taskstatelist != null ? (task_Controller.taskstatelist[0].done <= 1 ? '${task_Controller.taskstatelist[0].done} Task.' : '${task_Controller.taskstatelist[0].done} Task.') : 0}
                            '${task_Controller.taskstatelist[0].done}'
                            '${(task_Controller.taskstatelist[0].done <= 0) ? ' Task.' : ' Tasks.'}',
                            style: Themes().bodystyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        })));
  }
}
