// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_app/controllers/task_controller.dart';
import 'package:to_app/theme/theme.dart';
import 'package:to_app/ui/pages/add_task_page.dart';
import 'package:to_app/ui/size_config.dart';

class Add_Task_Bar extends StatelessWidget {
  final task_Controller;
  const Add_Task_Bar({required this.task_Controller}) ;

  @override
  Widget build(BuildContext context) {
    final TaskController task_Controller = Get.put(TaskController());

    return Container(
      padding: const EdgeInsets.only(right: 5, left: 15),
      height: SizeConfig.screenHeight * 0.1,
      width: SizeConfig.screenWidth,
      margin: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Themes().subheadinstyle,
              ),
              Text(
                'Today',
                style: Themes().headinstyle,
              )
            ],
          ),
          InkWell(
            child: const Image(
              image: AssetImage('images/add.png'),
            ),
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              task_Controller.getTasks();
              task_Controller.getTasksState();
            },
          ),
        ],
      ),
    );
  }
}
