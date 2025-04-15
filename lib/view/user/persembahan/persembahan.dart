import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/persembahan/persembahan_controller.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/user/persembahan/persembahan_detail.dart';
import 'package:gpdikpbaru/view/user/persembahan/widgets/bottomsheet.dart';

import 'package:sizer/sizer.dart';

import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Persembahan extends StatefulWidget {
  Persembahan({super.key});

  @override
  State<Persembahan> createState() => _PersembahanState();
}

class _PersembahanState extends State<Persembahan> {
  final themedark theme = Get.find();
  final home_controller2 session_C = Get.find();
  final Persembahan_Controller persembahan_C = Get.find();

  var selectedfABLocation = FloatingActionButtonLocation.endDocked;

  var _numberToMonthMap = {
    1: "JAN",
    2: "FEB",
    3: "MAR",
    4: "APR",
    5: "MEI",
    6: "JUN",
    7: "JUL",
    8: "AGU",
    9: "SEP",
    10: "OKT",
    11: "NOV",
    12: "DES",
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Persembahan", leading: true),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => persembahan_C.data_persembahan.isEmpty
                    ? Text(
                        "Anda Belum memiliki data Kolekte/Persembahan\n Klik Tombol Tambah dibawah untuk menambahkan kolekte.",
                        style: TextStyle(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      )
                    : SizedBox()),
                Obx(
                  () => ListView.builder(
                      itemCount: persembahan_C.data_persembahan.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data_persembahan =
                            persembahan_C.data_persembahan[index];
                        late Timestamp? t =
                            persembahan_C.data_persembahan[index].createdAt;
                        if (t == null) {
                          t = FieldValue.serverTimestamp() as Timestamp?;
                        } else {}
                        late DateTime createdAt = t!.toDate();
                        var modelPersembahan = persembahan_C.item(index);
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(GetRoutes.persembahandetail,
                                    arguments: PersembahanDetail(
                                        dataPersembahan: modelPersembahan));
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                child: SizedBox(
                                  height: 9.5.h,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/persembahan.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 6.w,
                                              child: Text(
                                                '${createdAt.day} \n${_numberToMonthMap[createdAt.month]}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: lightTextColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Obx(
                                        () => Container(
                                          height: double.infinity,
                                          color: theme.isLightTheme.value
                                              ? CtrWhite
                                              : CtrWhite3,
                                          child: Column(
                                            children: [
                                              Stack(children: [
                                                Container(
                                                  width: 55.w,
                                                  margin: EdgeInsets.only(
                                                      left: 15, top: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        NumberFormat.currency(
                                                                locale: 'id',
                                                                symbol: 'Rp ',
                                                                decimalDigits:
                                                                    0)
                                                            .format(
                                                                data_persembahan
                                                                    .nominal),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 11.sp),
                                                      ),
                                                      SizedBox(height: 0.3.h),
                                                      Text(
                                                        data_persembahan
                                                                    .status ==
                                                                "0"
                                                            ? "[Menunggu Pembayaran] \nKlik untuk selesaikan Pembayaran."
                                                            : data_persembahan
                                                                        .status ==
                                                                    "1"
                                                                ? "[Menunggu Validasi] \nPembayaran anda sedang divalidasi."
                                                                : "Pembayaran Kolekte Berhasil, Tuhan Yesus Memberkati.",
                                                        style: TextStyle(
                                                            color: theme
                                                                    .isLightTheme
                                                                    .value
                                                                ? txtBlack
                                                                : txtWhite,
                                                            fontSize: 8.sp),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: double.maxFinite,
                                                  margin: EdgeInsets.only(
                                                      right: 8, top: 5),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: badges.Badge(
                                                        badgeStyle:
                                                            badges.BadgeStyle(
                                                          shape: badges
                                                              .BadgeShape
                                                              .square,
                                                          badgeColor: data_persembahan
                                                                      .status ==
                                                                  "0"
                                                              ? badge_pending
                                                              : data_persembahan
                                                                          .status ==
                                                                      "1"
                                                                  ? badge_validasi
                                                                  : badge_success,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        badgeContent: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            data_persembahan
                                                                        .status ==
                                                                    "0"
                                                                ? 'Proses'
                                                                : data_persembahan
                                                                            .status ==
                                                                        "1"
                                                                    ? 'Butuh Validasi'
                                                                    : 'Selesai',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 7.sp),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                Container(
                                                  height: 7.h,
                                                  margin: EdgeInsets.only(
                                                    left: 2,
                                                    top: 8,
                                                    right: 3,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 16.sp,
                                                      color: lightBlueColor,
                                                    ),
                                                  ),
                                                ),
                                              ])
                                            ],
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: selectedfABLocation,
          floatingActionButton: SpeedDial(
              backgroundColor: CtrMainColor,
              icon: Icons.add,
              activeIcon: Icons.close,
              spacing: 3,
              childPadding: const EdgeInsets.all(5),
              spaceBetweenChildren: 4,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.library_add),
                  backgroundColor: Color.fromARGB(255, 39, 122, 195),
                  foregroundColor: Colors.white,
                  label: 'Tambah Kolekte',
                  onTap: () {
                    tambahkolekte_bottom(
                        text: 'ADD', addEditFlag: 1, docId: '');
                  },
                )
              ]),
          bottomNavigationBar: BottomAppBar(
            color: CtrMainColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 6.h,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Text(
                      "Klik Tombol + untuk Mengisi Kolekte",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: txtWhite),
                    ),
                  )),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
