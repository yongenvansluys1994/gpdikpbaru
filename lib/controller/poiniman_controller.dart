import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/profil/p_iman_controller.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'package:sizer/sizer.dart';

class poiniman_controller extends GetxController {
  final CountdownController _controllertimer =
      new CountdownController(autoStart: true);
  @override
  void onInit() async {
    super.onInit();
  }

  //nambah poin otomatis per waktu jika membuka menu
  Widget add_poin(
      {required String task,
      required double poin,
      required String text,
      required int seconds}) {
    return Countdown(
      controller: _controllertimer,
      seconds: seconds,
      build: (BuildContext context, double time) => SizedBox.shrink(),
      interval: Duration(milliseconds: 20),
      onFinished: () {
        _controllertimer.restart();
        fluttertoast(text: text);
        updatepoin(task: task, point: poin);
      },
    );
  }

  Widget add_poin_transparant(
      {required String task,
      required double poin,
      required String text,
      required int seconds}) {
    return Countdown(
      controller: _controllertimer,
      seconds: seconds,
      build: (BuildContext context, double time) => SizedBox.shrink(),
      interval: Duration(milliseconds: 20),
      onFinished: () {
        _controllertimer.restart();
        //fluttertoast(text: text);
        updatepoin(task: task, point: poin);
      },
    );
  }

  //logic nambah poin otomatis
  void updatepoin({required String task, required double point}) {
    final ReloadData = Get.find<home_controller2>();
    final p_iman = Get.find<p_iman_controller>();

    FirebaseFirestore.instance
        .collection("data_user")
        .doc(ReloadData.items[0].username)
        .collection('task')
        .doc(ReloadData.items[0].username)
        .update({
      task: (double.parse(p_iman.data_p_iman[0][task]) + point)
          .toStringAsFixed(3),
    });
  }

  //logic nambah poin dari hasil melakukan sesuatu di menu
  void updatepoinmanual(
      {required String task, required double point, required String text}) {
    final ReloadData = Get.find<home_controller2>();
    final p_iman = Get.find<p_iman_controller>();

    FirebaseFirestore.instance
        .collection("data_user")
        .doc(ReloadData.items[0].username)
        .collection('task')
        .doc(ReloadData.items[0].username)
        .update({
      task: (double.parse(p_iman.data_p_iman[0][task]) + point)
          .toStringAsFixed(3),
    }).whenComplete(() => fluttertoast(text: text));
  }

  void fluttertoast({required String text}) {
    Fluttertoast.showToast(
      gravity: ToastGravity.CENTER_RIGHT,
      backgroundColor: Color.fromARGB(0, 76, 175, 79),
      textColor: Color.fromARGB(192, 76, 175, 79),
      msg: '$text Poin Iman',
      fontSize: 13.sp,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
