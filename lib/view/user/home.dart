import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/common/responsive.dart';
import 'package:gpdikpbaru/common/styles.dart';

import 'package:gpdikpbaru/controller/home_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/profil/p_iman_controller.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/admin/berita/berita_detail.dart';
import 'package:gpdikpbaru/view/user/top_profil.dart';
import 'package:gpdikpbaru/widgets/drawer.dart';

import 'package:gpdikpbaru/widgets/modul_home.dart';
import 'package:gpdikpbaru/widgets/myclipper.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'dart:math' as math;
import 'package:badges/badges.dart' as badges;

import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  home_controller2 session_C = Get.find();
  final home_controller datalist_C = Get.find();
  final p_iman_controller p_iman_C = Get.find();
  themedark theme = Get.find();

  Home(this.session_C, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Get.find<home_controller2>().init();
        await Get.find<home_controller2>().checkinternet();
        await Get.find<home_controller2>().checkLatestVersion();
        await Get.find<home_controller>().controllerscroll();
        await Get.find<home_controller>().init();
        await Get.find<p_iman_controller>().proses_p_iman();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: MainDrawer(),
        appBar: CustomAppBar(title: ApiAuth.APP_NAME, leading: true),
        body: Stack(
          children: [
            ClipPath(
                clipper: MyClipper(), child: Container(color: CtrMainColor)),
            ListView(
              children: [
                TopProfil(session_C),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Obx(
                        () => Container(
                          width: MediaQuery.of(context).size.width,
                          height: 21.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: theme.isLightTheme.value
                                  ? CtrWhite
                                  : CtrWhite2,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(8, 6),
                                    color: lightGreenColor.withOpacity(0.3)),
                                BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(-1, -5),
                                    color: lightGreenColor.withOpacity(0.3))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 13.3.h,
                                      width: 42.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              session_C.dateFormatter(
                                                  DateTime.now()),
                                              style: defaultFont.copyWith(
                                                  fontSize: Responsive
                                                      .FONT_SIZE_DEFAULT)),
                                          Row(
                                            children: [
                                              Container(
                                                height: 4.h,
                                                width: 1.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomLeft,
                                                    stops: [
                                                      0.1,
                                                      0.3,
                                                      0.7,
                                                      0.9,
                                                    ],
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 200, 247, 241),
                                                      Color.fromARGB(
                                                          255, 211, 251, 247),
                                                      Color.fromARGB(
                                                          255, 244, 219, 219),
                                                      Color.fromARGB(
                                                          255, 254, 214, 204),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 0.8.h),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Ultah Minggu Ini",
                                                          style: defaultFontMed.copyWith(
                                                              fontSize: Responsive
                                                                  .FONT_SIZE_DEFAULT,
                                                              color:
                                                                  CtrMainColor2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800)),
                                                      Image.asset(
                                                        "assets/images/birthday.gif",
                                                        height: 3.h,
                                                        width: 5.w,
                                                      ),
                                                    ],
                                                  ),
                                                  AnimatedBuilder(
                                                    animation:
                                                        session_C.animation,
                                                    builder: (context, child) {
                                                      // Periksa apakah birthdayText kosong
                                                      return Container(
                                                        width: 39.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: Color.fromARGB(
                                                              255,
                                                              227,
                                                              247,
                                                              255),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: session_C
                                                                        .birthdayText
                                                                        .value ==
                                                                    ""
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        227,
                                                                        247,
                                                                        255)
                                                                : Color.fromARGB(
                                                                        255,
                                                                        20,
                                                                        201,
                                                                        138)
                                                                    .withOpacity(
                                                                    (0.5 + 0.5 * sin(session_C.animation.value * 2 * pi))
                                                                        .abs(),
                                                                  ),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.sp),
                                                          child:
                                                              AnimatedSwitcher(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    130), // Durasi animasi
                                                            transitionBuilder: (Widget
                                                                    child,
                                                                Animation<
                                                                        double>
                                                                    animation) {
                                                              return SlideTransition(
                                                                position: Tween<
                                                                    Offset>(
                                                                  begin: Offset(
                                                                      0,
                                                                      0.2), // Mulai dari bawah
                                                                  end: Offset(0,
                                                                      0), // Berakhir di posisi normal
                                                                ).animate(
                                                                    animation),
                                                                child: child,
                                                              );
                                                            },
                                                            child: Text(
                                                              session_C
                                                                  .birthdayText
                                                                  .value, // Nama ulang tahun
                                                              maxLines: 1,
                                                              key: ValueKey<
                                                                      String>(
                                                                  session_C
                                                                      .birthdayText
                                                                      .value), // Kunci unik

                                                              style: TextStyle(
                                                                fontSize: 9.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 1.h),
                                          Row(
                                            children: [
                                              Container(
                                                height: 4.h,
                                                width: 1.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomLeft,
                                                    stops: [
                                                      0.1,
                                                      0.3,
                                                      0.7,
                                                      0.9,
                                                    ],
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 109, 137, 203),
                                                      Color.fromARGB(
                                                          255, 129, 153, 209),
                                                      Color.fromARGB(
                                                          255, 244, 219, 219),
                                                      Color.fromARGB(
                                                          255, 254, 214, 204),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 0.8.h),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Ibadah Mendatang",
                                                      style: defaultFontMed.copyWith(
                                                          fontSize: Responsive
                                                              .FONT_SIZE_DEFAULT,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: Color.fromARGB(
                                                              255,
                                                              57,
                                                              103,
                                                              210))),
                                                  Container(
                                                      width: 39.w,
                                                      height: 2.6.h,
                                                      decoration: BoxDecoration(
                                                        color: txtMainColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5),
                                                        child: Marquee(
                                                          text:
                                                              ' ${session_C.nextEventText.value}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: txtBlack),
                                                          scrollAxis:
                                                              Axis.horizontal,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          blankSpace: 20.0,
                                                          velocity: 20.0,
                                                          pauseAfterRound:
                                                              Duration(
                                                                  seconds: 5),
                                                          startPadding: 10.0,
                                                          accelerationDuration:
                                                              Duration(
                                                                  seconds: 1),
                                                          accelerationCurve:
                                                              Curves.linear,
                                                          decelerationDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      500),
                                                          decelerationCurve:
                                                              Curves.easeOut,
                                                        ),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(GetRoutes.perjalanan_iman);
                                      },
                                      child: Container(
                                        height: 13.h,
                                        width: 32.w,
                                        child: SleekCircularSlider(
                                          appearance: CircularSliderAppearance(
                                              customColors: CustomSliderColors(
                                                  progressBarColors: [
                                                    Color.fromARGB(
                                                        255, 171, 220, 252),
                                                    Color.fromARGB(
                                                        255, 255, 218, 208),
                                                    Color.fromARGB(
                                                        255, 203, 251, 246),
                                                  ]),
                                              infoProperties: InfoProperties(
                                                  mainLabelStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          0, 255, 193, 7))),
                                              spinnerMode: false,
                                              angleRange: 360,
                                              size: 172,
                                              customWidths: CustomSliderWidths(
                                                  progressBarWidth: 8)),
                                          min: 0,
                                          max: 100,
                                          initialValue: 90,
                                          innerWidget: (double value) => Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Obx(() => Text(
                                                      "${double.parse(p_iman_C.sumpoin.toStringAsFixed(3))}",
                                                      style: TextStyle(
                                                          fontSize: 8.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: txtMainColor),
                                                    )),
                                                Text("Poin Iman",
                                                    style:
                                                        defaultFontMed.copyWith(
                                                            fontSize: Responsive
                                                                .FONT_SIZE_SMALL,
                                                            color:
                                                                txtMainColor)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                Container(
                                    height: 2.6.h,
                                    decoration: BoxDecoration(
                                      color: txtMainColor,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Marquee(
                                        text:
                                            '${session_C.alertberanda == "" ? "Selamat Datang di Aplikasi" : session_C.alertberanda}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: txtBlack),
                                        scrollAxis: Axis.horizontal,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        blankSpace: 20.0,
                                        velocity: 20.0,
                                        pauseAfterRound: Duration(seconds: 5),
                                        startPadding: 10.0,
                                        accelerationDuration:
                                            Duration(seconds: 1),
                                        accelerationCurve: Curves.linear,
                                        decelerationDuration:
                                            Duration(milliseconds: 500),
                                        decelerationCurve: Curves.easeOut,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Stack(
                  children: [
                    Obx(
                      () => Visibility(
                        visible: datalist_C.visible,
                        child: Positioned(
                          right: 0.w,
                          bottom: -5.h,
                          child: Transform.rotate(
                            angle: -math.pi / 2,
                            child: Lottie.asset(
                              'assets/lottie/scroll.json',
                              width: 25.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        // change your height based on preference
                        height: 29.5.h,
                        width: double.infinity,
                        child: VsScrollbar(
                          controller: datalist_C.scrollController,
                          showTrackOnHover: true, // default false
                          isAlwaysShown: true, // default false
                          scrollbarFadeDuration: Duration(
                              milliseconds:
                                  500), // default : Duration(milliseconds: 300)
                          scrollbarTimeToFade: Duration(
                              milliseconds:
                                  800), // default : Duration(milliseconds: 600)
                          style: VsScrollbarStyle(
                            hoverThickness: 10.0, // default 12.0
                            radius: Radius.circular(
                                12), // default Radius.circular(8.0)
                            thickness: 10.0, // [ default 8.0 ]
                            color: CtrMainColor, // default ColorScheme theme
                          ),
                          child: ListView(
                            controller: datalist_C.scrollController,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              // add your widgets here
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 13.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        modulHome(
                                            title: "Alkitab Online",
                                            modul: "alkitab",
                                            controller: session_C,
                                            badge: false,
                                            valueBadge: "",
                                            kategoriBadge: ""),
                                        SizedBox(width: 4.w),
                                        Obx(() => modulHome(
                                            title: "Warta Jemaat",
                                            modul: "jadwal",
                                            controller: session_C,
                                            badge: session_C.badgeStatus[
                                                    'warta_section'] ??
                                                false,
                                            valueBadge: "Baru",
                                            kategoriBadge: "warta_section")),
                                        SizedBox(width: 4.w),
                                        modulHome(
                                            title: "Live Chat",
                                            modul: "livechat",
                                            controller: session_C,
                                            badge: false,
                                            valueBadge: "Baru",
                                            kategoriBadge: ""),
                                        SizedBox(width: 4.w),
                                        Obx(() => modulHome(
                                            title: "Radio Rohani",
                                            modul: "radio",
                                            controller: session_C,
                                            badge: session_C.radioStatus.value,
                                            valueBadge: "Sedang Live",
                                            kategoriBadge: "")),
                                        SizedBox(width: 4.w),
                                        Obx(() => modulHome(
                                            title: "Materi Ibadah",
                                            modul: "materi",
                                            controller: session_C,
                                            badge: session_C
                                                    .badgeStatus['materi'] ??
                                                false,
                                            valueBadge: "Baru",
                                            kategoriBadge: "materi")),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 13.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        modulHome(
                                            title: "Ibadah Streaming",
                                            modul: "live",
                                            controller: session_C,
                                            badge: false,
                                            valueBadge: "",
                                            kategoriBadge: ""),
                                        SizedBox(width: 4.w),
                                        Obx(() => modulHome(
                                            title: "Renungan\n Harian",
                                            modul: "renungan",
                                            controller: session_C,
                                            badge: session_C
                                                    .badgeStatus['renungan'] ??
                                                false,
                                            valueBadge: "Baru",
                                            kategoriBadge: "renungan")),
                                        SizedBox(width: 4.w),
                                        modulHome(
                                            title: "Persembahan Online",
                                            modul: "persembahan",
                                            controller: session_C,
                                            badge: false,
                                            valueBadge: "",
                                            kategoriBadge: "persembahan"),
                                        SizedBox(width: 4.w),
                                        modulHome(
                                            title: "Majelis Gereja",
                                            modul: "contact",
                                            controller: session_C,
                                            badge: false,
                                            valueBadge: "",
                                            kategoriBadge: ""),
                                        SizedBox(width: 4.w),
                                        modulHome(
                                            title: "Games",
                                            modul: "games",
                                            controller: session_C,
                                            badge: false,
                                            valueBadge: "",
                                            kategoriBadge: "games")
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Obx(() => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          height: 21.h,
                          decoration: BoxDecoration(
                            color:
                                theme.isLightTheme.value ? CtrWhite : CtrWhite2,
                            borderRadius: BorderRadius.circular(17),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 7,
                                  offset: Offset(-1, 1),
                                  spreadRadius: 1),
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 2,
                                  offset: Offset(-1, -1),
                                  spreadRadius: 1),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10),
                                    child: Text(
                                      "Pengumuman",
                                      style: GoogleFonts.inter(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 73, 73, 73)),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(GetRoutes.renunganpage);
                                    },
                                    child: Wrap(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, right: 5),
                                          child: Text(
                                            "Lihat Semua",
                                            style: GoogleFonts.inter(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.w500,
                                                color: txtMainColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Obx(() {
                                return Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: datalist_C.datalist.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(2),
                                    itemBuilder: (context, index) {
                                      var datalist = datalist_C.datalist[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(GetRoutes.beritadetail,
                                              arguments: BeritaDetail(
                                                  detail: datalist));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 120,
                                          child: Column(
                                            children: [
                                              // Gambar dengan Badge
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      '${datalist.urlGambar}',
                                                      height: 11.h,
                                                      width: 37.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  // Badge di atas kanan gambar
                                                  Positioned(
                                                    top: 0,
                                                    right: 1,
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical:
                                                              4), // Sesuaikan padding
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: datalist
                                                                      .jenis ==
                                                                  "Renungan"
                                                              ? [
                                                                  Colors
                                                                      .blueAccent,
                                                                  Colors
                                                                      .lightBlueAccent
                                                                ]
                                                              : datalist.jenis ==
                                                                      "Pengumuman"
                                                                  ? [
                                                                      Colors
                                                                          .orangeAccent,
                                                                      Colors
                                                                          .deepOrangeAccent
                                                                    ]
                                                                  : [
                                                                      Colors
                                                                          .greenAccent,
                                                                      Colors
                                                                          .teal
                                                                    ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    3.5.sp),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                            blurRadius: 4,
                                                            offset:
                                                                Offset(2, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      alignment: Alignment
                                                          .center, // Pastikan teks berada di tengah
                                                      child: Text(
                                                        '${datalist.jenis}', // Value dari datalist.jenis
                                                        textAlign: TextAlign
                                                            .center, // Teks di tengah secara horizontal
                                                        style: TextStyle(
                                                          color: Colors
                                                              .white, // Warna teks badge
                                                          fontSize: 9
                                                              .sp, // Ukuran teks
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height:
                                                              1.2, // Sesuaikan tinggi baris teks
                                                          shadows: [
                                                            Shadow(
                                                              offset: Offset(1,
                                                                  1), // Posisi bayangan
                                                              blurRadius:
                                                                  2, // Tingkat blur bayangan
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5), // Warna bayangan
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Container(
                                                width: 40.w,
                                                child: Text(
                                                  '${datalist.judulRenungan}',
                                                  textAlign: TextAlign.center,
                                                  maxLines:
                                                      2, // Batasi teks hingga 2 baris
                                                  overflow: TextOverflow
                                                      .ellipsis, // Tambahkan "..." jika teks terlalu panjang
                                                  style: TextStyle(
                                                    color: txtBlack,
                                                    fontSize:
                                                        10.sp, // Ukuran font
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              })
                            ],
                          )),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
