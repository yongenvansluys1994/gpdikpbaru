import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

void getDefaultDialog(String text, String kategori, int timer) {
  Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.all(0),
      content: Column(
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Lottie.asset('assets/lottie/${kategori}.json',
              width: 60.w, repeat: false),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      radius: 10);

  //Auto dismissing after the 2 seconds
  // You can set the time as per your requirements in Duration
  // This will dismiss the dialog automatically after the time you
  // have mentioned
  Future.delayed(Duration(seconds: timer), () {
    Get.back();
  });
}

void getDefaultDialogFix(String text, String kategori) {
  Get.defaultDialog(
    title: "",
    titlePadding: EdgeInsets.all(0),
    content: Column(
      children: [
        Lottie.asset('assets/lottie/${kategori}.json',
            width: 60.w, repeat: false),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 0),
    radius: 10,
    textConfirm: "Ok",
    onConfirm: () {
      Get.back();
    },
  );

  //Auto dismissing after the 2 seconds
  // You can set the time as per your requirements in Duration
  // This will dismiss the dialog automatically after the time you
  // have mentioned
}

void getDefaultDialogtoHome(String text, String kategori, int timer) {
  Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.all(0),
      content: Column(
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Lottie.asset('assets/lottie/${kategori}.json',
              width: 60.w, repeat: false),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      radius: 10);
  Future.delayed(Duration(seconds: timer), () {
    Get.offAllNamed(GetRoutes.home);
  });
}

void getDialog(String title, String text) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        TextButton(
          child: Text("Ok"),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}

void AlertWaktu({required String menu}) async {
  await http.get(Uri.parse(ApiAuth.CEK_UTILITAS));
  Get.dialog(
    barrierDismissible: false,
    AlertDialog(
      title: Text("Pemberitahuan!"),
      content: Text(
          'Menu ${menu} tidak dapat diakses di pada Jam Ibadah, Terima Kasih'),
      actions: [
        TextButton(
            child: Text("Kembali"),
            onPressed: () {
              Get.back();
              Get.back();
            }),
      ],
    ),
  );
}
