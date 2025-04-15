import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/common/responsive.dart';
import 'package:gpdikpbaru/common/styles.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:sizer/sizer.dart';

Widget modulHome(
    {required String title,
    required String modul,
    required home_controller2 controller,
    required bool badge,
    required String valueBadge,
    required String kategoriBadge}) {
  return Container(
    height: 25.h,
    width: 20.5.w,
    child: Column(
      children: [
        Stack(
          children: [
            Ink(
              height: 8.5.h,
              width: 17.5.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.3,
                    0.7,
                    0.9,
                  ],
                  colors: colormenu2,
                ),
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(3, 3),
                      spreadRadius: 1),
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 4,
                      offset: Offset(-2, -2),
                      spreadRadius: 1),
                ],
              ),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/${modul}.png'))),
                    ),
                  ],
                ),
                onTap: () {
                  if (kategoriBadge.isNotEmpty) {
                    controller.markKategoriAsRead(kategoriBadge);
                  }

                  if (modul == "jadwal") {
                    Get.toNamed(GetRoutes.warta_jemaat,
                        arguments: controller.items[0]);
                  } else if (modul == "persembahan") {
                    Get.toNamed(GetRoutes.persembahan);
                  } else if (modul == "renungan") {
                    Get.toNamed(GetRoutes.renunganpage);
                  } else if (modul == "live") {
                    Get.toNamed(GetRoutes.livepage);
                  } else if (modul == "alkitab") {
                    Get.toNamed(GetRoutes.alkitab);
                  } else if (modul == "livechat") {
                    Get.toNamed(GetRoutes.livechat);
                  } else if (modul == "radio") {
                    Get.toNamed(GetRoutes.radio);
                  } else if (modul == "games") {
                    Get.toNamed(GetRoutes.games);
                  } else if (modul == "contact") {
                    Get.toNamed(GetRoutes.contact_person);
                  } else if (modul == "materi") {
                    Get.toNamed(GetRoutes.materi,
                        arguments: controller.items[0]);
                  }
                },
              ),
            ),
            // Tampilkan badge hanya jika badge == true
            if (badge)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.sp, vertical: 3.sp),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: valueBadge == "Baru"
                          ? [
                              Colors.blueAccent,
                              Colors.lightBlueAccent
                            ] // Warna biru untuk "Baru"
                          : [Colors.redAccent, Colors.orangeAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(3.sp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${valueBadge}', // Teks badge
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 7.9.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: defaultFont.copyWith(fontSize: Responsive.FONT_SIZE_DEFAULT),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
