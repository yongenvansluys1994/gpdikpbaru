import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/routes/routes.dart';

import 'package:sizer/sizer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData _darkTheme = ThemeData(
        fontFamily: 'proxima-nova',
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber,
          disabledColor: Colors.grey,
        ));

    ThemeData _lightTheme = ThemeData(
        fontFamily: 'proxima-nova',
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(255, 167, 245, 236),
        buttonTheme: ButtonThemeData(
          buttonColor: Color.fromARGB(255, 167, 245, 236),
          disabledColor: Colors.grey,
        ));
    return Sizer(builder: (contcontext, orientation, deviceTypeext) {
      return GetMaterialApp(
        theme: _lightTheme,
        darkTheme: _darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'GetX Example',
        initialRoute: GetRoutes.login,
        builder: EasyLoading.init(),
        getPages: GetRoutes.routes,
      );
    });
  }
}
