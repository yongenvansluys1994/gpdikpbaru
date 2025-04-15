import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';

import 'package:gpdikpbaru/controller/home_controller2.dart';

import 'package:gpdikpbaru/controller/livechat_controller.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/widgets/dismiss_keyboard.dart';
import 'package:gpdikpbaru/widgets/easythrottle.dart';

import 'package:gpdikpbaru/widgets/keyboard_chat.dart';

import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;
import 'package:timeago/timeago.dart' as timeago;

class livechatPage extends StatefulWidget {
  livechatPage({Key? key}) : super(key: key);

  @override
  State<livechatPage> createState() => _livechatPageState();
}

class _livechatPageState extends State<livechatPage> {
  themedark theme = Get.find();
  final home_controller2 session_C = Get.find();
  final Livechat_Controller controller = Get.put(Livechat_Controller());

  @override
  Widget build(BuildContext context) {
    final user = session_C.items[0];
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: false,
            appBar: CustomAppBar(title: "Live Chat", leading: true),
            body: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.data_livechat.length +
                    (controller.hasMoreData.value ? 1 : 0),
                physics: AlwaysScrollableScrollPhysics(),
                reverse: true,
                padding: EdgeInsets.only(bottom: 7.h), // 👈 Tambahkan ini
                itemBuilder: (context, index) {
                  if (index == controller.data_livechat.length) {
                    print(
                        "ListView index akhir: hasMoreData = ${controller.hasMoreData.value}, total = ${controller.data_livechat.length}");

                    if (controller.data_livechat.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text("Belum ada chat."),
                        ),
                      );
                    }

                    if (controller.hasMoreData.value) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return SizedBox.shrink(); // Tidak tampilkan apa-apa
                    }
                  }

                  var data = controller.data_livechat[index];
                  final currentTime = Timestamp.fromMicrosecondsSinceEpoch(
                      DateTime.now().millisecondsSinceEpoch);
                  Timestamp t = data['createdAt'] == null
                      ? currentTime
                      : data['createdAt'] as Timestamp;
                  DateTime date = t.toDate();

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 16.5.w,
                            child: Stack(
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Color(0xFF39D2C0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2, 2, 2, 2),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            1000), // Nilai besar untuk memastikan bulat sempurna
                                        child: Image.network(
                                          '${data['image_user']}',
                                          width: 9.8.w, // Lebar gambar
                                          height: 9.8
                                              .w, // Tinggi gambar harus sama dengan lebar untuk bentuk bulat
                                          fit: BoxFit
                                              .cover, // Menyesuaikan gambar agar pas di dalam lingkaran
                                        ),
                                      )),
                                ),
                                Positioned(
                                  left: 9.7.w,
                                  child: Image.asset(
                                    "assets/badge/${data['lencana']}",
                                    height: 4.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${data['nama']}",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Color.fromARGB(255, 22, 22, 22),
                                        fontStyle: data['nama'] == "Moderator"
                                            ? FontStyle
                                                .italic // Teks menjadi miring jika nama adalah "Moderator"
                                            : FontStyle
                                                .normal, // Teks normal untuk nama lainnya
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                      "${timeago.format(date)}",
                                      style: TextStyle(fontSize: 9.sp),
                                    ))
                                  ],
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 10.w, maxWidth: 65.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      badges.Badge(
                                        badgeStyle: badges.BadgeStyle(
                                          shape: badges.BadgeShape.square,
                                          badgeColor: Color.fromARGB(
                                              255, 223, 223, 223),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        badgeContent: Text("${data['text']}",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color.fromARGB(
                                                    255, 60, 60, 60))),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                    ],
                  );
                },
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
                                nama: user.nama,
                                id_user: user.idUser,
                                no_hp: user.username,
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
        ],
      ),
    );
  }
}
