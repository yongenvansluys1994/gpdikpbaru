import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class themedark extends GetxController {
  RxBool isLightTheme = false.obs;

  @override
  void onInit() async {
    super.onInit();

    getThemeStatus();
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', isLightTheme.value);
  }

  getThemeStatus() async {
    var isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : true;
    }).obs;
    isLightTheme.value = (await isLight.value)!;
    Get.changeThemeMode(isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }
}
