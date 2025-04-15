import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/comments_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/models/model_datarenungan.dart';

import 'package:badges/badges.dart' as badges;
import 'package:gpdikpbaru/widgets/dismiss_keyboard.dart';
import 'package:gpdikpbaru/widgets/easythrottle.dart';
import 'package:gpdikpbaru/widgets/keyboard_chat.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:like_button/like_button.dart';

class RenunganDetail extends StatefulWidget {
  final ModeldataRenungan detail;

  RenunganDetail({
    super.key,
    required this.detail,
  });

  @override
  State<RenunganDetail> createState() => _RenunganDetailState();
}

class _RenunganDetailState extends State<RenunganDetail> {
  final themedark theme = Get.find();
  final poiniman_controller poiniman_C = Get.find();
  final home_controller2 session_C = Get.find();
  final Comments_Controller controller = Get.put(Comments_Controller());

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    controller.changevalue(
        id: int.parse(widget.detail.idRenungan),
        id_user: int.parse(session_C.items[0].idUser),
        parent: "renungan");
    //mengirim value ID terlebih dahulu
  }

  @override
  Widget build(BuildContext context) {
    final user = session_C.items[0];
    // print(user.email);
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            extendBodyBehindAppBar: false,
            appBar: CustomAppBar(title: "Renungan Harian", leading: true),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.isLightTheme.value ? CtrWhite : CtrWhite3,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 160,
                            child: Stack(
                              alignment: AlignmentDirectional(0, 1),
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    child: Image.network(
                                      "${widget.detail.urlGambar}",
                                      width: double.infinity,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 1),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 24, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.account_circle,
                                              color: Color(0xFF39D2C0),
                                              size: 24,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 0, 0, 0),
                                              child: Text(
                                                'Admin',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color: Color(0xFF39D2C0),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 5.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4), // Sesuaikan padding
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: widget.detail.jenis ==
                                                      "Renungan"
                                                  ? [
                                                      Colors.blueAccent,
                                                      Colors.lightBlueAccent
                                                    ]
                                                  : widget.detail.jenis ==
                                                          "Pengumuman"
                                                      ? [
                                                          Colors.orangeAccent,
                                                          Colors
                                                              .deepOrangeAccent
                                                        ]
                                                      : [
                                                          Colors.greenAccent,
                                                          Colors.teal
                                                        ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(3.5.sp),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 4,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment
                                              .center, // Pastikan teks berada di tengah
                                          child: Text(
                                            '${widget.detail.jenis}', // Value dari widget.detail.jenis
                                            textAlign: TextAlign
                                                .center, // Teks di tengah secara horizontal
                                            style: TextStyle(
                                              color: Colors
                                                  .white, // Warna teks badge
                                              fontSize: 9.sp, // Ukuran teks
                                              fontWeight: FontWeight.bold,
                                              height:
                                                  1.2, // Sesuaikan tinggi baris teks
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(
                                                      1, 1), // Posisi bayangan
                                                  blurRadius:
                                                      2, // Tingkat blur bayangan
                                                  color: Colors.black
                                                      .withOpacity(
                                                          0.5), // Warna bayangan
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                            child: Text(
                              '${widget.detail.judulRenungan}',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Color(0xFF14181B),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 8, 4, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 0, 8),
                                        child: Icon(
                                          Icons.mode_comment_outlined,
                                          size: 24,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 8, 0),
                                        child: Obx(() => Text(
                                              '${controller.data_comments.length}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 8, 0, 8),
                                          child: Obx(
                                            () => LikeButton(
                                              size: 8.w,
                                              isLiked: controller.ownlikes == 0
                                                  ? false
                                                  : true,
                                              likeCount: controller.likes,
                                              countPostion: CountPostion.right,
                                              likeCountPadding: EdgeInsets.zero,
                                              onTap: controller.addLikes,
                                              likeBuilder: (bool isLiked) {
                                                return Icon(
                                                  Icons.thumb_up,
                                                  color: isLiked
                                                      ? Colors.pink
                                                      : Colors.black54,
                                                  size: 7.w,
                                                );
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 8, 8),
                                        child: Icon(
                                          Icons.bookmark_border,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 8, 8),
                                        child: Icon(
                                          Icons.ios_share,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                            child: Text(
                              '${widget.detail.isiRenungan}..',
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Komentar",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.w),
                          Obx(() => controller.data_comments.isEmpty
                              ? Center(
                                  child: Text(
                                    "Belum ada komentar",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : Container()),
                          Obx(
                            () => ListView.builder(
                                itemCount: controller.data_comments.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data_comments =
                                      controller.data_comments[index];
                                  //mengatasi error null timestamp saat sendchat
                                  final currentTime =
                                      Timestamp.fromMicrosecondsSinceEpoch(
                                          DateTime.now()
                                              .millisecondsSinceEpoch);
                                  Timestamp t = data_comments['createdAt'] ==
                                          null
                                      ? currentTime
                                      : data_comments['createdAt'] as Timestamp;
                                  late DateTime date = t.toDate();
                                  // end mengatasi error null timestamp saat sendchat

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
                                                  color: Color(0xFF39D2C0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                2, 2, 2, 2),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      child: Image.network(
                                                        '${data_comments['image_user']}',
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
                                                    "assets/badge/${data_comments['lencana']}",
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: RichText(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle: StrutStyle(
                                                            fontSize: 12.0),
                                                        text: TextSpan(
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                            text:
                                                                '${data_comments['nama']}'),
                                                      ),
                                                    ),
                                                    Container(
                                                        child: Text(
                                                      "${timeago.format(date)}",
                                                      style: TextStyle(
                                                          fontSize: 5.2.sp),
                                                    ))
                                                  ],
                                                ),
                                                Container(
                                                  constraints: BoxConstraints(
                                                      minWidth: 10.w,
                                                      maxWidth: 65.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      badges.Badge(
                                                        badgeStyle:
                                                            badges.BadgeStyle(
                                                          shape: badges
                                                              .BadgeShape
                                                              .square,
                                                          badgeColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  223,
                                                                  223,
                                                                  223),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        badgeContent: Text(
                                                            "${data_comments['text']}",
                                                            style: TextStyle(
                                                                fontSize: 9.sp,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        60,
                                                                        60,
                                                                        60))),
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
                                }),
                          ),
                          SizedBox(height: 5.h),
                          poiniman_C.add_poin(
                              task: "poin_task4",
                              poin: 0.002,
                              text: "+2",
                              seconds: 60),
                          SizedBox(height: 6.w),
                        ],
                      ),
                    ),
                  ),
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
                        controller: controller.textController,
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
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
                        dismissKeyboard();
                        easyThrottle(
                          handler: () {
                            controller.CheckSend(
                                text: controller.textController.text,
                                parent: "renungan",
                                id: widget.detail.idRenungan,
                                nama: user.nama,
                                id_user: user.idUser,
                                image_user: session_C.fotoprofil,
                                lencana: session_C.lencana);
                          },
                        );
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
        ),
      ],
    );
  }
}
