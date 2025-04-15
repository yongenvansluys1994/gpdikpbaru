import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/persembahan/persembahan_controller.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/models/model_persembahan.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

class PersembahanDetail extends StatefulWidget {
  final ModelPersembahan dataPersembahan;

  PersembahanDetail({super.key, required this.dataPersembahan});

  @override
  State<PersembahanDetail> createState() => _PersembahanDetailState();
}

class _PersembahanDetailState extends State<PersembahanDetail> {
  final themedark theme = Get.find();
  final home_controller2 session_C = Get.find();
  final Persembahan_Controller persembahan_C = Get.find();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Get.find<Persembahan_Controller>()
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
            appBar: CustomAppBar(title: "Detail Persembahan", leading: true),
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
                GetBuilder<Persembahan_Controller>(builder: (controller) {
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

                            return Obx(() => Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 87.h,
                                    decoration: BoxDecoration(
                                        color: theme.isLightTheme.value
                                            ? CtrWhite
                                            : CtrBlack2,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25)),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.2),
                                              offset: Offset(0, -4),
                                              blurRadius: 8)
                                        ]),
                                    child: dataDetail.status == "1"
                                        ? Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(height: 5.h),
                                                Text(
                                                    "Pembayaran Berhasil \nSedang menunggu validasi Sekretariat Gereja.",
                                                    textAlign: TextAlign.center,
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
                                            ),
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
                                                  Text("Pembayaran Berhasil",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.ptSans(
                                                          fontSize: 14.sp,
                                                          color:
                                                              Color(0xFF05d037),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Divider(),
                                                  SizedBox(height: 2.h),
                                                  Text(
                                                      NumberFormat.currency(
                                                              locale: 'id',
                                                              symbol: 'Rp ',
                                                              decimalDigits: 0)
                                                          .format(dataDetail
                                                              .nominal),
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
                                                  Divider(),
                                                  Container(
                                                    width: 95.w,
                                                    child: Column(
                                                      children: [
                                                        Text("Lukas 6:38",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 9.sp,
                                                                color:
                                                                    lightTextColor)),
                                                        Text(
                                                            "”Berilah dan kamu akan diberi: suatu takaran yang baik, yang dipadatkan, yang digoncang dan yang tumpah ke luar akan dicurahkan ke dalam ribaanmu. Sebab ukuran yang kamu pakai untuk mengukur, akan diukurkan kepadamu.”.",
                                                            textAlign: TextAlign
                                                                .center,
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
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "Metode Transfer Persembahan",
                                                                style: GoogleFonts.ptSans(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
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
                                                                fontSize:
                                                                    10.sp),
                                                          ),
                                                          subtitle: Text(
                                                              '${data_bank['nama_bank']}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      9.sp)),
                                                          trailing: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 18.sp,
                                                            color:
                                                                lightBlueColor,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.h),
                                                      Center(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "${data_bank['jenis'] == "Bank" ? "Nomor Rekening" : "Nomor HP "} ${data_bank['nama_bank']} Resmi Kami",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                )),
                                                            SizedBox(
                                                                height: 1.h),
                                                            Text(
                                                                "${data_bank['no_rek']}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .amber,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.sp,
                                                                )),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            SizedBox(
                                                              width: 40
                                                                  .w, // <-- Your width
                                                              height: 6
                                                                  .h, // <-- Your height
                                                              child: TextButton(
                                                                child: Text(
                                                                    'SALIN NOMOR',
                                                                    style: TextStyle(
                                                                        color:
                                                                            MainColor,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  primary:
                                                                      MainColor,
                                                                  onSurface:
                                                                      Colors
                                                                          .yellow,
                                                                  side: BorderSide(
                                                                      color:
                                                                          MainColor,
                                                                      width:
                                                                          1.5),
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(7))),
                                                                ),
                                                                onPressed: () {
                                                                  Clipboard.setData(ClipboardData(
                                                                          text:
                                                                              "${data_bank['no_rek']}"))
                                                                      .then(
                                                                          (_) {
                                                                    Snackbar_top(
                                                                        title:
                                                                            "Salin No Rekening",
                                                                        message:
                                                                            "No Rekening telah di salin",
                                                                        kategori:
                                                                            "success",
                                                                        duration:
                                                                            1);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 2.h),
                                                            Center(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                      "${data_bank['jenis'] == "Bank" ? "Nama Rekening" : "Nama "} :",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            11.sp,
                                                                      )),
                                                                  SizedBox(
                                                                      height:
                                                                          1.h),
                                                                  Text(
                                                                      "${data_bank['nama_rek']}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15.sp,
                                                                      )),
                                                                  SizedBox(
                                                                      height:
                                                                          2.h),
                                                                  Text(
                                                                      "Jumlah Bayar :",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            11.sp,
                                                                      )),
                                                                  SizedBox(
                                                                      height:
                                                                          1.h),
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
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20.sp,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  dataDetail.status == "1" ||
                                                          dataDetail.status ==
                                                              "2"
                                                      ? SizedBox.shrink()
                                                      : Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(), //container kosong agar card bisa dibawah
                                                              Column(
                                                                children: [
                                                                  Card(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100.w,
                                                                      child:
                                                                          ListTile(
                                                                        dense:
                                                                            true,
                                                                        visualDensity:
                                                                            VisualDensity(vertical: -4),
                                                                        trailing:
                                                                            SizedBox(
                                                                                child: OutlinedButton(
                                                                          onPressed:
                                                                              () {
                                                                            persembahan_C.showMyDialog(
                                                                                context: context,
                                                                                postID: widget.dataPersembahan.postID,
                                                                                user_nama: widget.dataPersembahan.user_nama);
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            side:
                                                                                const BorderSide(
                                                                              color: lightBlueColor2,
                                                                              width: 1,
                                                                            ),
                                                                            onPrimary:
                                                                                lightBlueColor2,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "Upload Bukti Transfer",
                                                                            style:
                                                                                TextStyle(fontSize: 9.sp),
                                                                          ),
                                                                        )),
                                                                        title:
                                                                            Text(
                                                                          "Cara Transfer",
                                                                          style:
                                                                              TextStyle(fontSize: 10.5.sp),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Card(
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100.w,
                                                                      child:
                                                                          ListTileTheme(
                                                                        dense:
                                                                            true,
                                                                        child:
                                                                            ExpansionTile(
                                                                          title:
                                                                              Text(
                                                                            "${data_bank['nama_bank']}",
                                                                            style:
                                                                                TextStyle(fontSize: 12.sp),
                                                                          ),
                                                                          children: <Widget>[
                                                                            ListTile(
                                                                                title: Text(
                                                                              "${data_bank['cara_bayar']}",
                                                                            ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        100.w,
                                                                    child: Text(
                                                                        "Segala Transaksi pada aplikasi ini telah Dilindungi dengan enkripsi keamanan demi menjaga privasi user.",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                9.sp,
                                                                            color: lightTextColor)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                ],
                                              ),
                                  ),
                                ));
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
