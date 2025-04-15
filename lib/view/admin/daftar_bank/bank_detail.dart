import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/kolekte_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';

import 'package:gpdikpbaru/models/model_persembahan.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

class BankDetail extends StatefulWidget {
  final ModelPersembahan dataPersembahan;

  BankDetail({super.key, required this.dataPersembahan});

  @override
  State<BankDetail> createState() => _BankDetailState();
}

class _BankDetailState extends State<BankDetail> {
  final home_controller2 session_C = Get.find();
  final Kolekte_Controller persembahan_C = Get.find();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Get.find<Kolekte_Controller>()
        .loadDetail(postID: widget.dataPersembahan.postID);
  }

  @override
  Widget build(BuildContext context) {
    late Timestamp t = widget.dataPersembahan.createdAt as Timestamp;
    late DateTime createdAt = t.toDate();

    final data_bank = persembahan_C.data_bank[0];

    return Stack(
      children: [
        Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Kolekte ",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                GetBuilder<Kolekte_Controller>(builder: (controller) {
                  return Obx(
                    () {
                      if (controller.isFailed) {
                        return Center(child: Text('Fetching data failed.'));
                      }

                      if (controller.isEmpty) {
                        return Center(child: Text('No data.'));
                      }
                      if (controller.isLoading) {
                        return Center(child: Text('Loading.'));
                      }
                      return ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var dataDetail = controller.data_persembahanDetail[
                                index]; // here is your wordItem ready to be used

                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 87.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(.2),
                                            offset: Offset(0, -4),
                                            blurRadius: 8)
                                      ]),
                                  child: dataDetail.status == "1"
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Pembayaran telah masuk \nMembutuhkan Verifikasi Admin",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.ptSans(
                                                          fontSize: 14.sp,
                                                          color:
                                                              Color(0xFF05d037),
                                                          fontWeight:
                                                              FontWeight.bold)),

                                                  // Container(
                                                  //   height: 15.h,
                                                  //   decoration: BoxDecoration(
                                                  //       color: Colors.white,
                                                  //       borderRadius: BorderRadius.circular(6)),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Card(
                                              elevation: 1,
                                              child: ListTile(
                                                leading: Container(
                                                    width: 15.w,
                                                    height: 7.h,
                                                    child: Image.network(
                                                        '${data_bank['image']}')),
                                                title: Text(
                                                  'Transfer Melalui (${data_bank['nama_bank']})',
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                ),
                                                subtitle: Text(
                                                    '${data_bank['nama_bank']}',
                                                    style: TextStyle(
                                                        fontSize: 9.sp)),
                                                trailing: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 18.sp,
                                                  color: lightBlueColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Center(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      "Telah dikirim ke ${data_bank['jenis'] == "Bank" ? "Nomor Rekening" : "Nomor HP "} ${data_bank['nama_bank']}",
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                      )),
                                                  SizedBox(height: 1.h),
                                                  Text("${data_bank['no_rek']}",
                                                      style: TextStyle(
                                                        color: Colors.amber,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.sp,
                                                      )),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  Center(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "${data_bank['jenis'] == "Bank" ? "Nama Rekening" : "Nama "} :",
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                            )),
                                                        SizedBox(height: 1.h),
                                                        Text(
                                                            "${data_bank['nama_rek']}",
                                                            style: TextStyle(
                                                              fontSize: 15.sp,
                                                            )),
                                                        SizedBox(height: 2.h),
                                                        Text("Jumlah Bayar :",
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                            )),
                                                        SizedBox(height: 1.h),
                                                        Text(
                                                            NumberFormat.currency(
                                                                    locale:
                                                                        'id',
                                                                    symbol:
                                                                        'Rp ',
                                                                    decimalDigits:
                                                                        0)
                                                                .format(widget
                                                                    .dataPersembahan
                                                                    .nominal),
                                                            style: TextStyle(
                                                              fontSize: 20.sp,
                                                            )),
                                                        SizedBox(height: 1.h),
                                                        Text(
                                                          "Periksa pada mutasi Transfer masuk pada Aplikasi M-Banking sebelum klik Verifikasi Pembayaran",
                                                          style: TextStyle(
                                                            fontSize: 11.sp,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(height: 2.h),
                                                        Text(
                                                            "Bukti Transfer :"),
                                                        Container(
                                                          width: 40.w,
                                                          height: 20.w,
                                                          child: (widget
                                                                      .dataPersembahan
                                                                      .bukti_bayar ==
                                                                  null)
                                                              ? Image.asset(
                                                                  "assets/images/default-img.png")
                                                              : GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    Get.to(() =>
                                                                        DetailScreen(
                                                                          url_gambar:
                                                                              '${widget.dataPersembahan.bukti_bayar}',
                                                                        ));
                                                                  },
                                                                  child: Image
                                                                      .network(
                                                                          '${widget.dataPersembahan.bukti_bayar}'),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(), //container kosong agar card bisa dibawah
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 85
                                                            .w, // <-- Your width
                                                        height: 5.5
                                                            .h, // <-- Your height
                                                        child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              minimumSize:
                                                                  Size(150, 43),
                                                              primary: Colors
                                                                  .teal[200],
                                                              onPrimary:
                                                                  Colors.white,
                                                              shape:
                                                                  new RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                        .circular(
                                                                        30.0),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Get.defaultDialog(
                                                                title:
                                                                    "Verifikasi Pembayaran Kolekte",
                                                                radius: 10,
                                                                middleText:
                                                                    "Apakah anda telah memastikan pembayaran telah masuk?",
                                                                textConfirm:
                                                                    "Verifikasi",
                                                                onConfirm: () {
                                                                  Get.back();
                                                                  persembahan_C.Verifikasi(
                                                                      postID: widget
                                                                          .dataPersembahan
                                                                          .postID,
                                                                      context:
                                                                          context);
                                                                },
                                                                textCancel:
                                                                    "Batal",
                                                              );
                                                            },
                                                            child: Text(
                                                              'Verifikasi Pembayaran',
                                                              style: TextStyle(
                                                                fontSize: 17.sp,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )),
                                                      ),
                                                      SizedBox(height: 15.h)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      : dataDetail.status == "2"
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Lottie.asset(
                                                    'assets/lottie/success.json',
                                                    width: 80.w,
                                                    repeat: false),
                                                Text(
                                                    "Pembayaran Berhasil di Verifikasi",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.ptSans(
                                                        fontSize: 14.sp,
                                                        color:
                                                            Color(0xFF05d037),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(height: 2.h),
                                                Text(
                                                    NumberFormat.currency(
                                                            locale: 'id',
                                                            symbol: 'Rp ',
                                                            decimalDigits: 0)
                                                        .format(
                                                            dataDetail.nominal),
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                    )),
                                                SizedBox(height: 5.h),
                                                Card(
                                                  elevation: 0,
                                                  child: ListTile(
                                                    leading: Container(
                                                        width: 15.w,
                                                        height: 7.h,
                                                        child: Image.network(
                                                            '${data_bank['image']}')),
                                                    title: Text(
                                                      'Transfer Melalui (${data_bank['nama_bank']})',
                                                      style: TextStyle(
                                                          fontSize: 10.sp),
                                                    ),
                                                    subtitle: Text(
                                                        '${data_bank['nama_bank']}',
                                                        style: TextStyle(
                                                            fontSize: 9.sp)),
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                Container(
                                                  width: 95.w,
                                                  child: Column(
                                                    children: [
                                                      Text("Lukas 6:38",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 9.sp,
                                                              color:
                                                                  lightTextColor)),
                                                      Text(
                                                          "”Berilah dan kamu akan diberi: suatu takaran yang baik, yang dipadatkan, yang digoncang dan yang tumpah ke luar akan dicurahkan ke dalam ribaanmu. Sebab ukuran yang kamu pakai untuk mengukur, akan diukurkan kepadamu.”.",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              color:
                                                                  lightTextColor)),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),
                                                Container(
                                                  width: 100.w,
                                                  child: Text(
                                                      "Segala Transaksi pada aplikasi ini telah Dilindungi dengan enkripsi keamanan demi menjaga privasi user.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 9.sp,
                                                          color:
                                                              lightTextColor)),
                                                ),
                                              ],
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 5.h),
                                                  Text(
                                                      "User telah Menginput Data Kolekte\n Sedang Menunggu Pembayaran",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.ptSans(
                                                          fontSize: 14.sp,
                                                          color: textColor,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      "${createdAt.day}-${createdAt.month}-${createdAt.year} ${createdAt.hour}:${createdAt.minute}:${createdAt.second}"),
                                                  SizedBox(height: 3.h),
                                                  Lottie.asset(
                                                    'assets/lottie/waiting_confirm.json',
                                                    width: 80.w,
                                                  ),
                                                ],
                                              ),
                                            )),
                            );
                          });
                    },
                  );
                }),
              ],
            )),
      ],
    );
  }
}

class DetailScreen extends StatelessWidget {
  final url_gambar;
  // In the constructor, require a Person
  DetailScreen({Key? key, required this.url_gambar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              '${url_gambar}',
            ),
          ),
        ),
      ),
    );
  }
}
