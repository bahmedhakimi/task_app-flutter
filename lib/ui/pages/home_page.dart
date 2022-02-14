// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors, non_constant_identifier_names, unused_local_variable, prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_app/controllers/task_controller.dart';
import 'package:to_app/services/notification_services.dart';
import 'package:to_app/ui/pages/login.dart';
import 'package:to_app/ui/pages/notification_screen.dart';
import 'package:to_app/ui/size_config.dart';
import 'package:to_app/ui/widgets/add_task_bar.dart';
import 'package:to_app/ui/widgets/person_info.dart';
import 'package:to_app/ui/widgets/select_date_bar.dart';
import 'package:to_app/ui/widgets/show_task.dart';
import 'package:to_app/theme/color/colors.dart';
import 'dart:math' as math;

import 'package:to_app/ui/widgets/task_state.dart'; // import this

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  DateTime selected_date = DateTime.now();
  final TaskController task_Controller = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    task_Controller.getTasks();
    task_Controller.getTasksState();
    task_Controller.get_user();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: AppColors.kLightYellow,
        appBar: AppBar(
          backgroundColor: AppColors.kDarkYellow,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  task_Controller.getTasks();
                  task_Controller.getTasksState();
                  task_Controller.get_user();
                  //Get.to(NotificationScreen(payload: 'title|desc|17:15AM'));
                },
                child: Image(
                  color: Colors.black,
                  width: SizeConfig.screenWidth * 0.06,
                  height: SizeConfig.screenWidth * 0.06,
                  image: AssetImage(
                    'images/cloud-computing.png',
                  ),
                ),
              ),
            )
          ],
          leading: InkWell(
            onTap: () {
              task_Controller.logout();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (builder) => Login()));
            },
            child: Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.rotationY(math.pi),
              child: Icon(
                Icons.logout,
                color: Colors.black87,
              ),
            ),
          ),
          elevation: 0,
          // ignore: prefer_const_literals_to_create_immutables
        ),
        body: Container(
          child: Column(
            children: [
//person name and picture
              Person_Info(task_Controller: task_Controller),
              Add_Task_Bar(task_Controller: task_Controller),
              Show_Task(
                notifyHelper: notifyHelper,
                selected_date: selected_date,
                task_Controller: task_Controller,
              ),
// to_do -- in progress -- done widget
              Task_State(
                  selected_date: selected_date,
                  task_Controller: task_Controller),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
// select date card
              Select_Date_Bar(
                fun: () => add_date_bar(context),
                text: 'Select Date',
                selectedDate: selected_date,
              ),
            ],
          ),
        ));
  }

  add_date_bar(BuildContext context) async {
    final lastdat = DateTime(2040);
    final DateTime? date = await showDatePicker(
            lastDate: DateTime(2040),
            context: context,
            firstDate: DateTime(1990),
            initialDate: selected_date)
        .then((value) {
      setState(() {
        if (value != null) {
          selected_date = value;
        }
      });
    });
  }
}
