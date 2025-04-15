import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/common/shared_prefs.dart';
import 'package:gpdikpbaru/models/model_profil.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class LoginController extends GetxController {
  late TextEditingController nikController, passwordController;
  CarouselController carouselController = CarouselController();
  int activeIndex = 0;
  int carouselCount = 3;
  bool isActive = false;

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final _mtoken = "".obs;
  final _sessionusername = "".obs;

  String get sessionusername => _sessionusername.value;
  String get mtoken => _mtoken.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkUser();
    requestPermission();
    loadFCM();
    listenFCM();

    nikController = TextEditingController();
    passwordController = TextEditingController();
  }

  buildCarousel() {
    return Container(
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/login-char.jpg',
                fit: BoxFit.cover,
                height: Get.height * 0.22, // Reduced height slightly
              ),
            ),
          ),
          SizedBox(height: 3.h), // Reduced vertical spacing
          Text(
            "Aplikasi ${ApiAuth.APP_NAME}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0XFF006298),
              fontSize: 14.sp, // Slightly reduced font size
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 3.h), // Reduced vertical spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              "Aplikasi GPdI Filadelfia Kota Bontang adalah platform kerohanian sehingga jemaat dapat tetap terhubung satu sama lain dengan kegiatan gereja kapan saja dan di mana saja.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 11.sp, // Slightly reduced font size
              ),
              maxLines: 4, // Limit number of lines
              overflow: TextOverflow.ellipsis, // Handle text overflow
            ),
          ),
        ],
      ),
    );
  }

  buildCarousel2() {
    return SizedBox(
      height: Get.height.h,
      width: Get.width.w,
      child: ListView(
        padding: EdgeInsets.all(16.sp),
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(15), // Adjust the radius as needed
            child: Image.asset(
              'assets/images/login-char2.jpg',
              fit: BoxFit.cover,
              // width: 100, // Adjust the width as needed
              // height: 100, // Adjust the height as needed
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text("Jatuh Tempo Pembayaran PBB Thn 2023 di Perpanjang!",
                textAlign: TextAlign.center,
                style: TextStyle(color: const Color(0XFF006298)),
                maxLines: 2),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              "Jatuh Tempo Pembayaran PBB 2023 di perpanjang sampai 24 Desember 2023, Ayo Manfaatkan Waktu Bayar PBB Tahun 2023 tanpa Denda.",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  changeCarouselIndicator(index, reason) {
    activeIndex = index;
    update();
  }

  checkUser() async {
    var shared = await SharedPrefs().getUser();

    if (shared != null) {
      Get.offAllNamed(GetRoutes.home);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    nikController.dispose();
    passwordController.dispose();
  }

  void getToken(String level) async {
    await FirebaseMessaging.instance.getToken().then((token) {
      _mtoken.value = token!;

      print(mtoken);

      saveToken(token, level);
    });
  }

  void saveToken(String token, String level) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(nikController.text)
        .set({
      'token': token,
    });
    if (level == "admin ") {
      FirebaseMessaging.instance.subscribeToTopic("admin");
      FirebaseMessaging.instance.subscribeToTopic("all");
    } else {
      FirebaseMessaging.instance.subscribeToTopic("user");
      FirebaseMessaging.instance.subscribeToTopic("all");
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // ignore: unused_local_variable
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  CheckLogin() {
    if (nikController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "No HP harus di isi", kategori: "error", duration: 1);
    } else if (passwordController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Password harus di isi", kategori: "error", duration: 1);
    } else {
      login();
    }
  }

  login() async {
    EasyLoading.show(status: 'Loading...');
    var response = await http.post(Uri.parse(ApiAuth.LOGIN), body: {
      "username": nikController.text,
      "password": passwordController.text,
    });
    var res = await jsonDecode(response.body);

    if (res['success']) {
      EasyLoading.dismiss();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 3);
      ModelProfil user = ModelProfil.fromJson(res['user']);
      await SharedPrefs().setUser(json.encode(user));

      getToken(user.level);
      Get.offAllNamed(GetRoutes.home);
    } else {
      EasyLoading.dismiss();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              sound: RawResourceAndroidNotificationSound('notif'),
              playSound: true,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'ic_notification',
              fullScreenIntent: false,
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notif'),
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
}
