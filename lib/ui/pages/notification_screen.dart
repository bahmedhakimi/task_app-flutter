// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_app/theme/color/colors.dart';
import 'package:to_app/theme/theme.dart';
import 'package:to_app/ui/size_config.dart';

class NotificationScreen extends StatefulWidget {
  final String payload;
  const NotificationScreen({required this.payload});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 3,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.4,
                      image: AssetImage(
                        'images/4685.jpg',
                      ),
                      fit: BoxFit.fill,
                    ),
                    color: AppColors.kDarkYellow),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        child: Image(
                          color: Colors.black,
                          width: SizeConfig.screenWidth * 0.07,
                          height: SizeConfig.screenHeight * 0.07,
                          alignment: Alignment.topLeft,
                          image: AssetImage('images/back.png'),
                        ),
                        onTap: () => Get.back()),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  width: SizeConfig.screenWidth * 0.20,
                                  height: SizeConfig.screenHeight * 0.20,
                                  alignment: Alignment.topLeft,
                                  image: AssetImage('images/active.png'),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome',
                                      style: Themes().headinstyle,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'You Have New Reminder',
                                      style: Themes().subtitestyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: SizeConfig.screenHeight * 0.18,
                              padding:
                                  EdgeInsets.only(right: 15, left: 5, top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ///  title
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 5),
                                        width: SizeConfig.screenWidth * 0.78,
                                        height: SizeConfig.screenHeight * 0.08,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image(
                                              width:
                                                  SizeConfig.screenWidth * 0.05,
                                              height: SizeConfig.screenHeight *
                                                  0.05,
                                              image: AssetImage(
                                                  'images/label.png'),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            //title
                                            Text(
                                              widget.payload
                                                  .toString()
                                                  .split('|')[0],
                                              style: Themes().subtitestyle,
                                            ),
                                          ],
                                        ),
                                      ),

                                      // date

                                      Expanded(
                                        child: Text(
                                          widget.payload
                                              .toString()
                                              .split('|')[2],
                                          style: Themes().bodystyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///  description

                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5),
                                      margin:
                                          EdgeInsets.only(left: 15, right: 2),
                                      width: double.infinity,
                                      child: Text(
                                        widget.payload.toString().split('|')[1],
                                        style: Themes().bodystyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
