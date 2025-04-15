import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/kolekte_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/admin/kolekte/kolekte_detail.dart';

import 'package:sizer/sizer.dart';

import 'package:intl/intl.dart';

class kolekteAdmin extends StatefulWidget {
  kolekteAdmin({super.key});

  @override
  State<kolekteAdmin> createState() => _kolekteAdminState();
}

class _kolekteAdminState extends State<kolekteAdmin> {
  final home_controller2 session_C = Get.find();
  final Kolekte_Controller persembahan_C = Get.find();

  var selectedfABLocation = FloatingActionButtonLocation.endDocked;
  String? imageRenungan = null;

  String? pathImage;

  String? fileNameImage;

  TextEditingController nama = TextEditingController();

  TextEditingController nominal = TextEditingController();

  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();

  var setDefaultMake = true, setDefaultMakeModel = true;

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

  KeyEventResult _handleKeyPress(FocusNode focusNode, RawKeyEvent event) {
    // handles submit on enter
    if (event.isKeyPressed(LogicalKeyboardKey.enter) && !event.isShiftPressed) {
      // _sendMessage();
      // handled means that the event will not propagate
      return KeyEventResult.handled;
    }
    // ignore every other keyboard event including SHIFT+ENTER
    return KeyEventResult.ignored;
  }

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
                                Get.toNamed(GetRoutes.kolektedetail,
                                    arguments: KolekteDetail(
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
                                        child: Container(
                                          height: double.infinity,
                                          color: Colors.white,
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
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    105,
                                                                    105,
                                                                    105),
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
                                      ),
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
        )
      ],
    );
  }
}
