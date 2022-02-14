// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_app/models/task.dart';
import 'package:to_app/theme/color/colors.dart';
import 'package:to_app/theme/theme.dart';
import 'package:to_app/ui/size_config.dart';
import 'package:to_app/ui/widgets/task_tile.dart';

class Show_Task extends StatefulWidget {
  final notifyHelper;
  final selected_date;
  final task_Controller;

  Show_Task({
    required this.notifyHelper,
    required this.selected_date,
    required this.task_Controller,
  });

  @override
  _Show_TaskState createState() => _Show_TaskState();
}

class _Show_TaskState extends State<Show_Task> {
  @override
  Widget build(BuildContext context) {
    buildbottomsheet({
      required String label,
      required Function() ontap,
      required String image,
    }) {
      return GestureDetector(
        onTap: ontap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: SizeConfig.screenWidth * 0.15,
          width: SizeConfig.screenWidth * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.kGreen,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Image(
                    width: SizeConfig.screenWidth * 0.10,
                    height: SizeConfig.screenHeight * 0.10,
                    image: AssetImage(image),
                  ),
                  onTap: ontap,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: Themes().titestyle,
                ),
              ],
            ),
          ),
        ),
      );
    }

    showbottomsheet(BuildContext context, Task task) {
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(top: 5),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == '1'
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == '1'
                  ? SizeConfig.screenHeight * 0.3
                  : SizeConfig.screenHeight * 0.39),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            AppColors.kDarkYellow,
            AppColors.kDarkYellow.withOpacity(0.7)
          ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.kGreen),
                ),
              ),
              const SizedBox(height: 20),
              task.isCompleted == '1'
                  ? Container()
                  : buildbottomsheet(
                      label: 'Task Completed',
                      ontap: () async {
                        widget.notifyHelper.cancelNotification(task);
                        await widget.task_Controller.task_complited(task.id!);
                        Get.back();
                      },
                      image: 'images/checked.png'),
              buildbottomsheet(
                  label: 'Delete Task ',
                  ontap: () async {
                    widget.notifyHelper.cancelNotification(task);
                    await widget.task_Controller.deletTasks(
                        task.id!, task.isCompleted);
                    Get.back();
                  },
                  image: 'images/delete.png'),
              buildbottomsheet(
                  label: 'Cancel Task',
                  ontap: () => Get.back(),
                  image: 'images/close.png')
            ],
          ),
        ),
      );
    }

    indecator_lenght() {
      int index = 0, ind_lenght = 0;
      while (index < widget.task_Controller.tasklist.length) {
        Task task = widget.task_Controller.tasklist[index];
        if (task.repeat == 'Daily' ||
            task.date == DateFormat.yMd().format(widget.selected_date) ||
            (task.repeat == 'Weekly' &&
                (widget.selected_date
                            .difference(DateFormat.yMd().parse(task.date))
                            .inDays %
                        7 ==
                    0)) ||
            (task.repeat == 'Monthly' &&
                (DateFormat.yMd().parse(task.date).day ==
                    widget.selected_date.day))) {
          ind_lenght++;
        }
        index++;
      }
      return ind_lenght;
    }

    return Expanded(
      child: Obx(() {
        if (widget.task_Controller.tasklist.isEmpty) {
          return SizedBox(
            child: no_taskmessage(),
          );
        } else {
          if (indecator_lenght() == 0) {
            return no_task();
          } else {
            return SingleChildScrollView(
              child: SizedBox(
                  height: SizeConfig.screenHeight * 0.30,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.task_Controller.tasklist.length,
                      itemBuilder: (BuildContext context, int index) {
                        Task task = widget.task_Controller.tasklist[index];

                        DateTime date = DateFormat.jm().parse(task.startTime);

                        var mytime = DateFormat('hh:mm').format(date);
                        //print(mytime.toString().split(':')[1]);

                        widget.notifyHelper.scheduledNotification(
                            int.parse(mytime.toString().split(':')[0]),
                            int.parse(mytime.toString().split(':')[1]),
                            task);
                        if (task.repeat == 'Daily' ||
                            task.date ==
                                DateFormat.yMd().format(widget.selected_date) ||
                            (task.repeat == 'Weekly' &&
                                (widget.selected_date
                                            .difference(DateFormat.yMd()
                                                .parse(task.date))
                                            .inDays %
                                        7 ==
                                    0)) ||
                            (task.repeat == 'Monthly' &&
                                (DateFormat.yMd().parse(task.date).day ==
                                    widget.selected_date.day))) {
                          return GestureDetector(
                              onTap: () => showbottomsheet(context, task),
                              child: TaskTile(task));
                        } else {
                          return const SizedBox();
                        }
                      })),
              /* AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(seconds: 2),
                          child: SlideAnimation(
                            verticalOffset: 300,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () => showbottomsheet(context, task),
                                child: TaskTile(task),
                              ),
                            ),
                          ),
                        ); */
              /* CirclePageIndicator(
                  size: 16.0,
                  selectedSize: 18.0,
                  dotColor: Colors.black,
                  selectedDotColor: Colors.blue,
                  itemCount: task_Controller.tasklist.length,
                  currentPageNotifier: currentPage,
                ) */
            );
          }
        }
      }),
    );
  }
}

no_taskmessage() {
  return Stack(
    children: [
      SingleChildScrollView(
        child: Wrap(
          direction: SizeConfig.orientation == Orientation.landscape
              ? Axis.horizontal
              : Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizeConfig.orientation == Orientation.landscape
                ? const SizedBox(height: 5)
                : const SizedBox(height: 5),
            SvgPicture.asset(
              'images/task.svg',
              color: AppColors.primaryClr,
              height: 100,
            ),
            SizeConfig.orientation == Orientation.landscape
                ? const SizedBox(height: 5)
                : const SizedBox(height: 5),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: Text(
                'You do not have any tasks yet\nAdd new tasks to make your days productive.',
                style: Themes().subheadinstyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

no_task() {
  return Container(
    alignment: Alignment.center,
    child: SingleChildScrollView(
      child: Wrap(
          direction: SizeConfig.orientation == Orientation.landscape
              ? Axis.horizontal
              : Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.15,
              child: Text(
                'You Do Not Have Any\n Tasks For Today.',
                style: Themes().subheadinstyle,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
    ),
  );
}
