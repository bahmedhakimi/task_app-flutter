// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:to_app/ui/size_config.dart';
import 'package:to_app/theme/theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

   InputField(
      {required this.title, required this.hint, this.controller, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Themes().titestyle),
          Container(
            padding: const EdgeInsets.only(top: 8,left: 10),
            width: SizeConfig.screenWidth,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                  controller: controller,
                  style: Themes().subtitestyle,
                  readOnly: widget != null ? true: false,
                  decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 0)),
                      hintText: hint,
                      hintStyle: Themes().subtitestyle),
                )),
                widget ?? Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
