import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller_pelwap.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';

import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/user/jadwal/jadwal_detail.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class jadwalCard_pelwap extends StatefulWidget {
  String kategori;
  jadwalCard_pelwap({super.key, required this.kategori});

  @override
  State<jadwalCard_pelwap> createState() => _jadwalCard_pelwapState();
}

class _jadwalCard_pelwapState extends State<jadwalCard_pelwap> {
  themedark theme = Get.find();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Get.find<Jadwal_Controller_pelwap>()
        .loadGetJadwal(kategori: widget.kategori);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Jadwal_Controller_pelwap>(builder: (jadwal_C) {
      return Obx(
        () {
          if (jadwal_C.isFailed) {
            return NoData(theme: theme);
          }

          if (jadwal_C.isEmpty) {
            return NoData(theme: theme);
          }

          if (jadwal_C.isLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.2),
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    lightBlueColor,
                    Color.fromARGB(255, 116, 205, 219),
                  ]),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                    topRight: Radius.circular(48),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: SizedBox(
                    height: 14.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var datajadwal = jadwal_C.dataJadwal[
                    index]; // here is your wordItem ready to be used
                var modeljadwal = jadwal_C.item(index);
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            lightBlueColor,
                            Color.fromARGB(255, 116, 205, 219),
                          ]),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                            topRight: Radius.circular(48),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(5, 5),
                                color: lightBlueColor.withOpacity(0.4)),
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(-2, -2),
                                color: lightBlueColor.withOpacity(0.4))
                          ]),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        child: SizedBox(
                          height: 12.h,
                          child: Row(
                            children: [
                              Obx(() => Container(
                                    width: 88,
                                    color: theme.isLightTheme.value
                                        ? CtrMainColor2
                                        : CtrMainDark,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 15.w,
                                          child: Text(
                                            '${datajadwal.tanggal2}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 17.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(),
                                            children: [
                                              TextSpan(
                                                text: '${datajadwal.hari}\n',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  fontSize: 8.sp,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '${datajadwal.jam}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 9.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Obx(() => Expanded(
                                    child: Container(
                                      height: double.infinity,
                                      color: theme.isLightTheme.value
                                          ? CtrWhite
                                          : CtrWhite3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Image.asset(
                                                'assets/images/dots.png',
                                                height: 5.h,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      '${datajadwal.lokasi}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 11.sp,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 8, 10, 8),
                                                      width: double.infinity,
                                                      height: 0.5,
                                                      color: Colors.grey[200],
                                                    ),
                                                    Text(
                                                      '${datajadwal.alamat}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  style: TextStyle(),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Susunan\n',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 7.sp,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'Pelayan',
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  style: TextStyle(),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Data\n',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 7.sp,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'PIC',
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(GetRoutes.jadwaldetail,
                                arguments:
                                    jadwalDetail(dataJadwal: modeljadwal));
                          },
                          splashColor: Colors.teal[200],
                          splashFactory: InkSplash.splashFactory,
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
      );
    });
  }
}

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.theme,
  });

  final themedark theme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                lightBlueColor,
                Color.fromARGB(255, 116, 205, 219),
              ]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
                topRight: Radius.circular(48),
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 7,
                    offset: Offset(5, 5),
                    color: lightBlueColor.withOpacity(0.4)),
                BoxShadow(
                    blurRadius: 7,
                    offset: Offset(-2, -2),
                    color: lightBlueColor.withOpacity(0.4))
              ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: SizedBox(
              height: 12.h,
              child: Row(
                children: [
                  Container(
                    width: 88,
                    color: theme.isLightTheme.value
                        ? Colors.blueGrey
                        : CtrMainDark,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 15.w,
                          child: Text(
                            ' ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(),
                            children: [
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 241, 241, 241),
                                  fontSize: 8.sp,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: theme.isLightTheme.value ? CtrWhite : CtrWhite3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Text(
                              'Tidak ada Jadwal',
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              splashColor: Colors.teal[200],
              splashFactory: InkSplash.splashFactory,
            ),
          ),
        ),
      ],
    );
  }
}
