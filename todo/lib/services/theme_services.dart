import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeServices {
  GetStorage _box = GetStorage();
  String _key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode) {
    _box.write(_key, isDarkMode);
  }

  _loadThemeBox() {
    return _box.read(_key) ?? false;
  }

  ThemeMode get theme => _loadThemeBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(theme);
    _saveThemeToBox(!_loadThemeBox());
  }
}
