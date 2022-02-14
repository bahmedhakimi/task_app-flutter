// ignore_for_file: use_key_in_widget_constructors, unnecessary_null_comparison, unused_label

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_app/services/theme_services.dart';
import 'package:to_app/ui/pages/login.dart';
import 'package:to_app/theme/theme.dart';

import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  var token = GetStorage().read('token');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: token != null ? const MyApp() : const Login()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}



/* Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: indecator_lenght(),
                  itemBuilder: (_, int index, int i) {
                    Task task = task_Controller.tasklist[index];
                    DateTime date = DateFormat.jm().parse(task.startTime);

                    var mytime = DateFormat('hh:mm').format(date);
                    //print(mytime.toString().split(':')[1]);
                    notifyHelper.scheduledNotification(
                        int.parse(mytime.toString().split(':')[0]),
                        int.parse(mytime.toString().split(':')[1]),
                        task);
                    if (task.repeat == 'Daily' ||
                        task.date == DateFormat.yMd().format(selected_date) ||
                        (task.repeat == 'Weekly' &&
                            (selected_date
                                        .difference(
                                            DateFormat.yMd().parse(task.date))
                                        .inDays %
                                    7 ==
                                0)) ||
                        (task.repeat == 'Monthly' &&
                            (DateFormat.yMd().parse(task.date).day ==
                                selected_date.day))) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: SizeConfig.screenWidth * 0.80,
                        child: TaskTile(task),
                      );
                    } else {
                      return Container();
                    }
                  },
                  options: CarouselOptions(
                      enlargeCenterPage: true,
                      onPageChanged: (index, _) {
                        setState(() {
                          current_index = index;
                        });
                      },
                      height: 300,
                      initialPage: 0),
                  carouselController: carousel_controller,
                ),
                const SizedBox(
                  height: 5,
                ),
                builindicator()
              ],
            ), */