import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Snackbar_top(
    {required String title,
    required String message,
    required String kategori,
    required int duration}) {
  Get.snackbar(
    title,
    message,
    icon: Icon(kategori == "success" ? Icons.check : Icons.error,
        color: Colors.black, size: 8.8.w),
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: duration),
    backgroundColor: Colors.white,
    backgroundGradient: kategori == "success"
        ? LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(255, 245, 232, 232),
              Color.fromARGB(255, 248, 236, 232),
              Color.fromARGB(255, 198, 251, 238),
              Color.fromARGB(255, 206, 249, 247),
            ],
          )
        : LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(197, 251, 114, 104),
              Color.fromARGB(210, 254, 122, 113),
              Color.fromARGB(209, 253, 149, 142),
              Color.fromARGB(209, 255, 171, 165),
            ],
          ),
  );
}

Snackbar_bottom(
    {required String title,
    required String message,
    required String kategori,
    required int duration}) {
  Get.snackbar(
    title,
    message,
    icon: Icon(kategori == "success" ? Icons.check_box : Icons.error,
        color: Colors.black, size: 8.8.w),
    snackPosition: SnackPosition.BOTTOM,
    duration: Duration(seconds: duration),
    backgroundColor: Colors.white,
    backgroundGradient: kategori == "success"
        ? LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(255, 245, 232, 232),
              Color.fromARGB(255, 248, 236, 232),
              Color.fromARGB(255, 198, 251, 238),
              Color.fromARGB(255, 206, 249, 247),
            ],
          )
        : LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(197, 251, 114, 104),
              Color.fromARGB(210, 254, 122, 113),
              Color.fromARGB(209, 253, 149, 142),
              Color.fromARGB(209, 255, 171, 165),
            ],
          ),
  );
}

RawSnackbar_bottom(
    {required String message,
    required String kategori,
    required int duration}) {
  Get.rawSnackbar(
    messageText: Text(message, style: TextStyle(fontSize: 11.sp)),
    snackPosition: SnackPosition.BOTTOM,
    icon: Icon(kategori == "success" ? Icons.check_box : Icons.error,
        color: Colors.black, size: 8.8.w),
    backgroundColor: Colors.white,
    backgroundGradient: kategori == "success"
        ? LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(255, 143, 251, 156),
              Color.fromARGB(255, 130, 252, 144),
              Color.fromARGB(255, 120, 252, 135),
              Color.fromARGB(255, 93, 250, 111),
            ],
          )
        : LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(197, 251, 114, 104),
              Color.fromARGB(210, 254, 122, 113),
              Color.fromARGB(209, 253, 149, 142),
              Color.fromARGB(209, 255, 171, 165),
            ],
          ),
    duration: Duration(seconds: duration),
  );
}

RawSnackbar_top(
    {required String message,
    required String kategori,
    required int duration}) {
  Get.rawSnackbar(
    messageText: Text(message, style: TextStyle(fontSize: 11.sp)),
    snackPosition: SnackPosition.TOP,
    icon: Icon(kategori == "success" ? Icons.check_box : Icons.error,
        color: Colors.black, size: 8.8.w),
    backgroundColor: Colors.white,
    backgroundGradient: kategori == "success"
        ? LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(255, 143, 251, 156),
              Color.fromARGB(255, 130, 252, 144),
              Color.fromARGB(255, 120, 252, 135),
              Color.fromARGB(255, 93, 250, 111),
            ],
          )
        : LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(197, 251, 114, 104),
              Color.fromARGB(210, 254, 122, 113),
              Color.fromARGB(209, 253, 149, 142),
              Color.fromARGB(209, 255, 171, 165),
            ],
          ),
    duration: Duration(seconds: duration),
  );
}
