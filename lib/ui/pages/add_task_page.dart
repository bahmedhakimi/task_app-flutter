// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_app/controllers/task_controller.dart';
import 'package:to_app/models/task.dart';
import 'package:to_app/theme/color/colors.dart';
import 'package:to_app/theme/theme.dart';
import 'package:to_app/ui/size_config.dart';
import 'package:to_app/ui/widgets/button.dart';
import 'package:to_app/ui/widgets/input_field.dart';
import 'dart:math';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage();

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController title_controller = TextEditingController(text: '');
  TextEditingController note_controller = TextEditingController(text: '');
  final TaskController task_Controller = Get.put(TaskController());

  DateTime selecte_date = DateTime.now();
  String star_time = DateFormat('hh:mm a').format(DateTime.now()).toString();

  int selected_remind = 5;
  List<int> remind_list = [5, 10, 15, 20];
  String selected_repeat = 'None';
  List<String> repeat_list = ['None', 'Daily', 'Weekly', 'Monthly'];
  int selectedcolor = 0;
  List<String> colors = ['green', 'red', 'yellow', 'blue'];
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLightYellow,
      appBar: AppBar(
        backgroundColor: AppColors.kDarkYellow,
        leading: IconButton(
          color: Colors.black87,
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 18,
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.07,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColors.kDarkYellow,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                    bottomLeft: Radius.circular(80),
                  )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Create New Task',
                      style: Themes().headinstyle,
                    ),
                  ]),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InputField(
                      title: 'Title',
                      hint: 'Enter title here',
                      controller: title_controller,
                    ),
                    InputField(
                      title: 'Note',
                      hint: 'Enter note here',
                      controller: note_controller,
                    ),
                    InputField(
                      title: 'Date',
                      hint: DateFormat.yMd().format(selecte_date),
                      widget: IconButton(
                        color: AppColors.kGreen,
                        onPressed: () {
                          getDateFromUser();
                        },
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.kGreen,
                        ),
                      ),
                    ),
                    InputField(
                      title: 'Start Time',
                      hint: star_time,
                      widget: IconButton(
                        onPressed: () {
                          getTimeFromUser();
                        },
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: AppColors.kGreen,
                        ),
                      ),
                    ),
                    InputField(
                        title: 'Remind',
                        hint: '$selected_remind',
                        widget: DropdownButton(
                          items: remind_list
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text('$item'),
                                  ))
                              .toList(),
                          style: Themes().subtitestyle,
                          underline: Container(height: 0),
                          iconEnabledColor: AppColors.kGreen,
                          iconSize: 30,
                          onChanged: (int? value) {
                            setState(() {
                              selected_remind = value!;
                            });
                          },
                        )),
                    InputField(
                        title: 'Repeat',
                        hint: selected_repeat,
                        widget: DropdownButton(
                          items: repeat_list
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ))
                              .toList(),
                          style: Themes().subtitestyle,
                          underline: Container(
                            height: 0,
                          ),
                          onChanged: (value) {
                            setState(() {
                              selected_repeat = value.toString();
                            });
                          },
                        )),
                    MyButton(
                        label: 'Create Task',
                        ontap: () {
                          setState(() {
                            selectedcolor = random.nextInt(4);
                          });
                          validation();
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validation() {
    if (title_controller.text.isEmpty || note_controller.text.isEmpty) {
      Get.snackbar('reaquired', 'All field are required',
          backgroundColor: AppColors.primaryClr,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          colorText: Colors.white,
          animationDuration: Duration(milliseconds: 800));
    } else {
      add_task_to_database();
      Get.back();
      task_Controller.getTasks();
    }
  }

  add_task_to_database() {
    var data = Task(
      title: title_controller.text,
      note: note_controller.text,
      color: colors[selectedcolor],
      date: DateFormat.yMd().format(selecte_date),
      startTime: star_time,
      isCompleted: '0',
      remind: selected_remind.toString(),
      repeat: selected_repeat,
    ).toJson();
    task_Controller.insert_date(data);
  }

  void getDateFromUser() async {
    DateTime? datepicker = await showDatePicker(
        context: context,
        initialDate: selecte_date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));
    if (datepicker != null) {
      setState(() {
        selecte_date = datepicker;
      });
    }
  }

  void getTimeFromUser() async {
    TimeOfDay? timepicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (timepicked != null) {
      String formatted_time = timepicked.format(context);
      setState(() {
        star_time = formatted_time;
      });
    } else {
      print('enter time ');
    }
  }
}
