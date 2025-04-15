import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future GetLoader() {
  return Get.defaultDialog(
      title: "Loading",
      content: CircularProgressIndicator(),
      barrierDismissible: false);
}
