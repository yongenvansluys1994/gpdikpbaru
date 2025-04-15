import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/common/responsive.dart';
import 'package:gpdikpbaru/common/styles.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/controller/warta/comments_warta_controller.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/admin/jadwal/jadwal_edit.dart';
import 'package:gpdikpbaru/view/user/jadwal/widgets/pic.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gpdikpbaru/widgets/dismiss_keyboard.dart';
import 'package:gpdikpbaru/widgets/easythrottle.dart';
import 'package:gpdikpbaru/widgets/keyboard_chat.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:sizer/sizer.dart';

class jadwalDetail extends StatefulWidget {
  final ModelJadwal dataJadwal;
  jadwalDetail({super.key, required this.dataJadwal});

  @override
  State<jadwalDetail> createState() => _jadwalDetailState();
}

class _jadwalDetailState extends State<jadwalDetail> {
  final themedark theme = Get.find();
  final poiniman_controller poiniman_C = Get.find();
  final home_controller2 session_C = Get.find();
  final Jadwal_Controller jadwal_C = Get.find();
  final CommentsWartaController comments_C = Get.find();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    comments_C.firstRun(
        id: int.parse(widget.dataJadwal.idJadwal), parent: "warta");
    //mengirim value ID terlebih dahulu
  }

  @override
  Widget build(BuildContext context) {
    final dataJadwal = widget.dataJadwal;
    final user = session_C.items[0];
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Detail Jadwal", leading: true),
          body: GestureDetector(
            onTap: () {
              dismissKeyboard();
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    dataJadwal.kategori == "ibadah_minggu"
                        ? "Ibadah Minggu Raya"
                        : dataJadwal.kategori == "doa_persekutuan"
                            ? "Doa Persekutuan"
                            : dataJadwal.kategori == "ibadah_pelprap"
                                ? "Ibadah Pelprap"
                                : dataJadwal.kategori == "ibadah_pelprip"
                                    ? "Ibadah Pelprip"
                                    : dataJadwal.kategori == "ibadah_pelwap"
                                        ? "Ibadah Pelwap"
                                        : "",
                    style: defaultFontBold.copyWith(
                        fontSize: Responsive.FONT_SIZE_VERY_LARGE),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Obx(
                  () => Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 87.h,
                      decoration: BoxDecoration(
                        color: theme.isLightTheme.value ? CtrWhite : CtrBlack2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.2),
                            offset: Offset(0, -4),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 24, right: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/images/img_ibadah.jpg",
                                  height: 16.h,
                                  width: 88.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Icon(
                                          Icons.date_range,
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                            "${dataJadwal.tanggalLengkap}",
                                            style: defaultFontBold.copyWith(
                                                fontSize: Responsive
                                                    .FONT_SIZE_DEFAULT)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Icon(
                                          Icons.access_time,
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text("${dataJadwal.jam}",
                                            style: defaultFontBold.copyWith(
                                                fontSize: Responsive
                                                    .FONT_SIZE_DEFAULT)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  dataJadwal.kategori == "ibadah_minggu"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 85.w, // <-- Your width
                                              height: 4.h, // <-- Your height
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize: Size(150, 43),
                                                    primary: Colors.teal[200],
                                                    onPrimary: Colors.white,
                                                    shape:
                                                        new RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Stack(
                                                    children: <Widget>[
                                                      // Stroked text as border.
                                                      Text(
                                                        'JOIN LIVE STREAMING',
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          foreground: Paint()
                                                            ..style =
                                                                PaintingStyle
                                                                    .stroke
                                                            ..strokeWidth = 1.7
                                                            ..color = textColor,
                                                        ),
                                                      ),
                                                      // Solid text as fill.
                                                      Text(
                                                        'JOIN LIVE STREAMING',
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            )
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text("${dataJadwal.lokasi}",
                                            style: defaultFontBold.copyWith(
                                                fontSize: Responsive
                                                    .FONT_SIZE_DEFAULT)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Icon(
                                          Icons.segment,
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text("${dataJadwal.alamat}",
                                            style: defaultFont.copyWith(
                                                fontSize: Responsive
                                                    .FONT_SIZE_DEFAULT)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Center(
                                    child: Text("Susunan Pelayan",
                                        style: defaultFontBold.copyWith(
                                            fontSize: Responsive
                                                .FONT_SIZE_EXTRA_LARGE)),
                                  ),
                                  Center(
                                    child: Container(
                                      margin: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 162, 209, 210),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Table(
                                        border: TableBorder(
                                          horizontalInside: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 162, 209, 210),
                                          ),
                                          verticalInside: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 162, 209, 210),
                                          ),
                                          right: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 162, 209, 210),
                                          ),
                                        ),
                                        columnWidths: const {
                                          0: FixedColumnWidth(130),
                                          1: FlexColumnWidth(),
                                        },
                                        children: [
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Text('Hamba Tuhan',
                                                    style: defaultFontBold),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Text(
                                                    '${dataJadwal.hambaTuhan ?? "-"}'),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Text('Worship Leader',
                                                    style: defaultFontBold),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Text(
                                                    '${dataJadwal.wl ?? "-"}'),
                                              ),
                                            ],
                                          ),
                                          if (dataJadwal.kategori ==
                                              "ibadah_minggu")
                                            TableRow(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Text('Singer',
                                                      style: defaultFontBold),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Text(
                                                      '${dataJadwal.singer ?? "-"}'),
                                                ),
                                              ],
                                            ),
                                          if (dataJadwal.kategori ==
                                              "ibadah_minggu")
                                            TableRow(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Text('Pemain Musik',
                                                      style: defaultFontBold),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Text(
                                                      '${dataJadwal.pmusik ?? "-"}'),
                                                ),
                                              ],
                                            ),
                                          if (dataJadwal.kategori ==
                                              "ibadah_minggu")
                                            TableRow(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Text('P.Kolekte',
                                                      style: defaultFontBold),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Text(
                                                      '${dataJadwal.pkolekte ?? "-"}'),
                                                ),
                                              ],
                                            ),
                                          if (dataJadwal.kategori ==
                                              "ibadah_minggu")
                                            TableRow(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Text('Pen.Tamu',
                                                      style: defaultFontBold),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Text(
                                                      '${dataJadwal.ptamu ?? "-"}'),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  user.level == "admin"
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 85.w, // <-- Your width
                                                  height: 32, // <-- Your height
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        minimumSize:
                                                            Size(150, 43),
                                                        primary:
                                                            Colors.teal[200],
                                                        onPrimary: Colors.white,
                                                        shape:
                                                            new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  30.0),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            GetRoutes
                                                                .jadwaledit,
                                                            arguments:
                                                                jadwalEditAdmin(
                                                                    dataJadwal:
                                                                        dataJadwal));
                                                      },
                                                      child: Stack(
                                                        children: <Widget>[
                                                          // Stroked text as border.

                                                          Text(
                                                            'Ubah Jadwal',
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 1.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 85.w, // <-- Your width
                                                  height: 33, // <-- Your height
                                                  child: TextButton(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0),
                                                      child: Text(
                                                          'Hapus Jadwal',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.red,
                                                      onSurface: Colors.yellow,
                                                      side: BorderSide(
                                                          color: Colors.red,
                                                          width: 2),
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          25))),
                                                    ),
                                                    onPressed: () {
                                                      Get.defaultDialog(
                                                        title: "Hapus Jadwal",
                                                        middleText:
                                                            "Apakah anda yakin ingin Menghapus Jadwal ini?",
                                                        textConfirm: "Hapus",
                                                        textCancel: "Batal",
                                                        onConfirm: () {
                                                          jadwal_C.hapusjadwal(
                                                              id_jadwal:
                                                                  dataJadwal
                                                                      .idJadwal);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  Divider(),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.sp),
                                    child: Text(
                                      "Komentar",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 1.w),
                                  Obx(() {
                                    if (comments_C.dataComments.isEmpty) {
                                      // Tampilkan pesan jika tidak ada komentar
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.sp),
                                          child: Text(
                                            "Belum ada komentar.",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    // Tampilkan daftar komentar jika ada
                                    return ListView.builder(
                                      itemCount: comments_C.dataComments.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var dataComments =
                                            comments_C.dataComments[index];
                                        // Mengatasi error null timestamp saat sendchat
                                        final currentTime = Timestamp
                                            .fromMicrosecondsSinceEpoch(
                                                DateTime.now()
                                                    .millisecondsSinceEpoch);
                                        Timestamp t =
                                            dataComments['createdAt'] == null
                                                ? currentTime
                                                : dataComments['createdAt']
                                                    as Timestamp;
                                        late DateTime date = t.toDate();
                                        // End mengatasi error null timestamp saat sendchat

                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 12.w,
                                                  child: Stack(
                                                    children: [
                                                      Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color:
                                                            Color(0xFF39D2C0),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(2,
                                                                      2, 2, 2),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            child:
                                                                Image.network(
                                                              '${dataComments['image_user']}',
                                                              height: 3.4.h,
                                                              width: 3.4.h,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 7.w,
                                                        child: Image.asset(
                                                          "assets/badge/${dataComments['lencana']}",
                                                          height: 3.h,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 80.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: RichText(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              strutStyle:
                                                                  StrutStyle(
                                                                      fontSize:
                                                                          12.0),
                                                              text: TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                text:
                                                                    '${dataComments['nama']}',
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              "${timeago.format(date)}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      7.2.sp),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        constraints:
                                                            BoxConstraints(
                                                          minWidth: 10.w,
                                                          maxWidth: 65.w,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            badges.Badge(
                                                              badgeStyle: badges
                                                                  .BadgeStyle(
                                                                shape: badges
                                                                    .BadgeShape
                                                                    .square,
                                                                badgeColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        223,
                                                                        223,
                                                                        223),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              badgeContent:
                                                                  Text(
                                                                "${dataComments['text']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      9.sp,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          60,
                                                                          60,
                                                                          60),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 2.h),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 30,
                                right: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // dataJadwal.kategori == "ibadah_minggu"
                //     ? WidgetPIC(modelJadwal: dataJadwal)
                //     : SizedBox.shrink(),
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: 1,
            child: Padding(
              padding: isKeyboardOpen
                  ? EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 10.0,
                      right: 10.0,
                    )
                  : const EdgeInsets.only(
                      bottom: 10.0, left: 10.0, right: 10.0),
              child: Row(
                children: [
                  // Input Komentar
                  Expanded(
                    child: TextFormField(
                      controller: comments_C.textController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        prefixIcon: keyboard_chat(session_C),
                        hintText: 'Tambahkan Komentar...',
                        hintStyle: TextStyle(color: txtBlack2),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).errorColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  // Tombol Kirim
                  ElevatedButton(
                    onPressed: () {
                      if (comments_C.textController.text.isNotEmpty) {
                        dismissKeyboard();
                        easyThrottle(
                          handler: () {
                            comments_C.checkAndSend(
                              text: comments_C.textController.text,
                              parent: "warta",
                              id: comments_C.id.value.toString(),
                              nama: user.nama,
                              id_user: user.idUser,
                              image_user: session_C.fotoprofil,
                              lencana: session_C.lencana,
                            );
                          },
                        );
                      } else {
                        Get.snackbar(
                          "Error",
                          "Komentar tidak boleh kosong",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Warna tombol
                      onPrimary: Colors.white, // Warna ikon
                      minimumSize: Size(50, 50), // Ukuran tombol
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Radius sudut tombol
                      ),
                      elevation: 2, // Efek bayangan
                    ),
                    child: Icon(
                      Icons.send_outlined,
                      color: Colors.white, // Warna ikon
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
