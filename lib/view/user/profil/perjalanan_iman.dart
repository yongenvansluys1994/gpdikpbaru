import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';

import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/profil/p_iman_controller.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/view/user/profil/widgets/bottomsheet.dart';
import 'package:gpdikpbaru/widgets/myclipper.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class perjalananIman extends StatefulWidget {
  @override
  State<perjalananIman> createState() => _perjalananImanState();
}

class _perjalananImanState extends State<perjalananIman> {
  final themedark theme = Get.find();
  home_controller2 session_C = Get.find();

  p_iman_controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
            clipper: MyClipperMedium(),
            child: Container(
              color: Color.fromARGB(255, 133, 219, 207),
            )),
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Perjalanan Iman", leading: true),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.data_p_iman.length,
                    physics: PageScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data_p_iman = controller.data_p_iman[index];
                      //mengatasi error null timestamp saat sendchat

                      // end mengatasi error null timestamp saat sendchat

                      return Column(
                        children: [
                          SizedBox(height: 0.5.h),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 18.w,
                                    height: 8.5.h,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(0, 233, 239, 57),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2, 2, 2, 2),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Obx(() => Image.asset(
                                              "assets/badge/${session_C.lencana}",
                                            )),
                                      ),
                                    ),
                                  ),
                                  Lottie.asset(
                                    'assets/lottie/glow.json',
                                    width: 19.w,
                                  ),
                                ],
                              ),
                              Obx(() => Container(
                                    height: 8.5.h,
                                    width: 65.w,
                                    decoration: BoxDecoration(
                                      color: theme.isLightTheme.value
                                          ? CtrWhite
                                          : CtrBlack2,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 2,
                                          offset: Offset(3, 3),
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 4,
                                          offset: Offset(-1, -1),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Lencana kamu saat ini",
                                            style: TextStyle(
                                                fontSize: 11.5.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                              "Klik Lencana yang telah Complete untuk dapat memakainya."),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task1'],
                                  poin_task: data_p_iman['poin_task1'],
                                  lencana: "1.png",
                                  teks:
                                      "Dapatkan poin Maksimal dengan Registrasi Akun");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/1.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task1']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman1 >= 0.999
                                          ? 1
                                          : controller.poin_iman1,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman1 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman1 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman1 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task2'],
                                  poin_task: data_p_iman['poin_task2'],
                                  lencana: "2.png",
                                  teks:
                                      "Kumpulkan poin dengan Membaca Alkitab, kamu akan mendapatkan poin sebanyak 5 setiap 30 detik saat Membaca Alkitab.");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/2.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task2']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman2 >= 0.999
                                          ? 1
                                          : controller.poin_iman2,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman2 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman2 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman2 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task3'],
                                  poin_task: data_p_iman['poin_task3'],
                                  lencana: "3.png",
                                  teks:
                                      "Kumpulkan poin dengan Menonton Ibadah Live Streaming, kamu akan mendapatkan poin sebanyak 5 setiap 30 detik saat Membaca Alkitab.");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/3.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task3']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman3 >= 0.999
                                          ? 1
                                          : controller.poin_iman3,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman3 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman3 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman3 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task4'],
                                  poin_task: data_p_iman['poin_task4'],
                                  lencana: "4.png",
                                  teks:
                                      "Kumpulkan poin dengan Membaca Renungan Harian, kamu akan mendapatkan poin sebanyak 5 setiap 30 detik saat Membaca Alkitab.");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/4.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task4']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman4 >= 0.999
                                          ? 1
                                          : controller.poin_iman4,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman4 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman4 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman4 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task5'],
                                  poin_task: data_p_iman['poin_task5'],
                                  lencana: "5.png",
                                  teks:
                                      "Kumpulkan poin dengan Melakukan Persembahan Online, kamu akan mendapatkan poin sebanyak 50 setiap melakukan Persembahan Online");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/5.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task5']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman5 >= 0.999
                                          ? 1
                                          : controller.poin_iman5,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman5 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman5 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman5 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task6'],
                                  poin_task: data_p_iman['poin_task6'],
                                  lencana: "6.png",
                                  teks:
                                      "Kumpulkan poin dengan Memberi Like pada setiap Postingan Ibadah Live Streaming & Renungan Harian, kamu akan mendapatkan poin sebanyak 5 setiap memberi Like.");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/6.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task6']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman6 >= 0.999
                                          ? 1
                                          : controller.poin_iman6,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman6 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman6 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman6 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task7'],
                                  poin_task: data_p_iman['poin_task7'],
                                  lencana: "7.png",
                                  teks:
                                      "Kumpulkan poin dengan Memberi Komentar pada setiap Postingan Ibadah Live Streaming & Renungan Harian, kamu akan mendapatkan poin sebanyak 5 setiap memberi Komentar.");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/7.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task7']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman7 >= 0.999
                                          ? 1
                                          : controller.poin_iman7,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman7 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman7 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman7 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task8'],
                                  poin_task: data_p_iman['poin_task8'],
                                  lencana: "8.png",
                                  teks:
                                      "Kumpulkan poin dengan Berpartisipasi di Live Chat, kamu akan mendapatkan poin sebanyak 5 setiap mengirim pesan di Live Chat.");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/8.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task8']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman8 >= 0.999
                                          ? 1
                                          : controller.poin_iman8,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman8 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman8 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman8 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task9'],
                                  poin_task: data_p_iman['poin_task9'],
                                  lencana: "9.png",
                                  teks:
                                      "Kumpulkan poin dengan Bermain Game di menu Games, kamu akan mendapatkan poin sebanyak 5 setiap bermain di Menu Games.");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/9.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task9']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman9 >= 0.999
                                          ? 1
                                          : controller.poin_iman9,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman9 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman9 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman9 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task10'],
                                  poin_task: data_p_iman['poin_task10'],
                                  lencana: "10.png",
                                  teks:
                                      "Kumpulkan poin dengan mendengarkan Radio Rohani Online, kamu akan mendapatkan poin sebanyak 5 setiap mengikuti Radio Rohani Online");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/10.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task10']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman10 >= 0.999
                                          ? 1
                                          : controller.poin_iman10,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman10 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman10 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman10 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () {
                              view_lencana(
                                  sessionC: session_C,
                                  p_imanC: controller,
                                  nm_task: data_p_iman['nm_task11'],
                                  poin_task: data_p_iman['poin_task11'],
                                  lencana: "11.png",
                                  teks:
                                      "Kumpulkan poin dengan mendengarkan Radio Rohani Online, kamu akan mendapatkan poin sebanyak 5 setiap mengikuti Lagu Rohani Online");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/badge/10.png",
                                  width: 11.w,
                                  height: 14.w,
                                ),
                                SizedBox(width: 2.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data_p_iman['nm_task11']}",
                                      style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SimpleAnimationProgressBar(
                                      height: 3.h,
                                      width: 70.w,
                                      backgroundColor: Colors.grey.shade800,
                                      foregrondColor: Colors.purple,
                                      ratio: controller.poin_iman11 >= 0.999
                                          ? 1
                                          : controller.poin_iman11,
                                      direction: Axis.horizontal,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: const Duration(seconds: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      gradientColor: LinearGradient(colors: [
                                        controller.poin_iman11 >= 0.999
                                            ? Color.fromARGB(255, 216, 224, 153)
                                            : Color.fromARGB(
                                                255, 129, 194, 188),
                                        controller.poin_iman11 >= 0.999
                                            ? Color.fromARGB(255, 226, 226, 122)
                                            : Color.fromARGB(255, 41, 165, 152)
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.poin_iman11 >= 0.999
                                              ? Color.fromARGB(
                                                  255, 199, 206, 130)
                                              : Color.fromARGB(
                                                  255, 129, 194, 188),
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
