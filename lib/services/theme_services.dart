import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage box = GetStorage();
  final key = 'isDarkMode';

  savethemtobox(bool isDarkMode) =>box.write(key, isDarkMode);
  
  bool loadthemfrombox() => box.read<bool>(key) ?? false;

  ThemeMode get theme => loadthemfrombox() ? ThemeMode.dark : ThemeMode.light;

  void swithchtheme() {
    Get.changeThemeMode(loadthemfrombox()?ThemeMode.light:ThemeMode.dark);
    savethemtobox(!loadthemfrombox());
  }
}
