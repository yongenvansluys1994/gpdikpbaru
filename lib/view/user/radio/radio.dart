import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';

import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';
import 'package:gpdikpbaru/controller/radio/radio_controller.dart';

import 'package:badges/badges.dart' as badges;
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/widgets/dismiss_keyboard.dart';
import 'package:gpdikpbaru/widgets/easythrottle.dart';
import 'package:gpdikpbaru/widgets/keyboard_chat.dart';

import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RadioLive extends StatefulWidget {
  RadioLive({
    super.key,
  });

  @override
  State<RadioLive> createState() => _RadioLiveState();
}

class _RadioLiveState extends State<RadioLive> {
  themedark theme = Get.find();
  final home_controller2 session_C = Get.find();
  final Radio_Controller controller = Get.find();
  final poiniman_controller poiniman_C = Get.find();
  @override
  Widget build(BuildContext context) {
    final user = session_C.items[0];
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Obx(() {
      if (!controller.isYoutubeControllerReady.value) {
        return Center(
          child:
              CircularProgressIndicator(), // Tampilkan loader jika belum siap
        );
      }

      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller.youtubeController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          onReady: () {
            controller.isPlayerReady = true;
          },
        ),
        builder: (context, player) => Scaffold(
          appBar: CustomAppBar(title: "Radio Rohani Online", leading: true),
          body: GestureDetector(
            onTap: () {
              dismissKeyboard();
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.statusRadio == true
                    ? player
                    : Container(
                        height: 20.h,
                        child: Center(
                          child: Text(
                            "Sedang Offline",
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                  child: Text(
                    '${controller.judulRadio}',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Color(0xFF14181B),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Live Chat",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Obx(() => SizedBox(
                                height: 3.h,
                                width: 28.w,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Menampilkan dialog dengan daftar nama pengguna online
                                    Get.dialog(
                                      AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        title: Text("Viewers Online"),
                                        content: Container(
                                          width: double.maxFinite,
                                          constraints: BoxConstraints(
                                            maxHeight:
                                                300, // kontrol tinggi list agar tidak overflow
                                          ),
                                          child: controller.onlineUsers.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    "Tidak ada pengguna online",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Plus Jakarta Sans',
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )
                                              : ListView.builder(
                                                  itemCount: controller
                                                      .onlineUsers.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      leading:
                                                          Icon(Icons.person),
                                                      title: Text(
                                                        controller
                                                            .onlineUsers[index],
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Text("OK"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Warna latar belakang transparan
                                    shadowColor: Colors
                                        .transparent, // Hilangkan bayangan
                                    padding: EdgeInsets
                                        .zero, // Hilangkan padding default
                                    splashFactory:
                                        InkRipple.splashFactory, // Efek ripple
                                    onPrimary:
                                        Colors.blueAccent, // Warna efek splash
                                  ),
                                  child: Text(
                                    "Viewers Online: ${controller.totalOnline.value}",
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 9.5.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.bottomSheet(
                            CustomBottomSheet(
                                controller:
                                    controller), // Panggil class CustomBottomSheet
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
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
                          Icons.settings,
                          color: Colors.white, // Warna ikon
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.data_livechat.length +
                          (controller.hasMoreData.value ? 1 : 0),
                      physics: AlwaysScrollableScrollPhysics(),
                      reverse: true,
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
                        final currentTime =
                            Timestamp.fromMicrosecondsSinceEpoch(
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
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      GetRoutes.profil_user,
                                      arguments: {
                                        'id': int.parse(data['id_user']),
                                        'name': data['nama'],
                                        'username': data['no_hp'],
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 15.w,
                                    child: Stack(
                                      children: [
                                        Card(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          color: Color(0xFF39D2C0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 2, 2, 2),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    1000), // Nilai besar untuk memastikan bulat sempurna
                                                child: Image.network(
                                                  '${data['image_user']}',
                                                  width: 8.w, // Lebar gambar
                                                  height: 8
                                                      .w, // Tinggi gambar harus sama dengan lebar untuk bentuk bulat
                                                  fit: BoxFit
                                                      .cover, // Menyesuaikan gambar agar pas di dalam lingkaran
                                                ),
                                              )),
                                        ),
                                        Positioned(
                                          left: 8.5.w,
                                          child: Image.asset(
                                            "assets/badge/${data['lencana']}",
                                            height: 3.6.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                GetRoutes.profil_user,
                                                arguments: {
                                                  'id': int.parse(
                                                      data['id_user']),
                                                  'name': data['nama'],
                                                  'username': data['no_hp'],
                                                },
                                              );
                                            },
                                            child: Text(
                                              "${data['nama']}",
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color.fromARGB(
                                                    255, 22, 22, 22),
                                                fontStyle: data['nama'] ==
                                                        "Moderator"
                                                    ? FontStyle
                                                        .italic // Teks menjadi miring jika nama adalah "Moderator"
                                                    : FontStyle
                                                        .normal, // Teks normal untuk nama lainnya
                                              ),
                                            ),
                                          ),
                                          data['nama'] == "Moderator"
                                              ? SizedBox.shrink()
                                              : Container(
                                                  child: Text(
                                                  "${timeago.format(date)}",
                                                  style:
                                                      TextStyle(fontSize: 9.sp),
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
                                                badgeColor:
                                                    data['nama'] == "Moderator"
                                                        ? Colors.transparent
                                                        : Color.fromARGB(
                                                            255, 223, 223, 223),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              badgeContent: Text(
                                                "${data['text']}",
                                                style: TextStyle(
                                                  fontSize: data['nama'] ==
                                                          "Moderator"
                                                      ? 9.sp
                                                      : 10.5.sp,
                                                  color: Color.fromARGB(
                                                      255, 60, 60, 60),
                                                  fontStyle: data['nama'] ==
                                                          "Moderator"
                                                      ? FontStyle
                                                          .italic // Teks menjadi miring jika nama adalah "Moderator"
                                                      : FontStyle
                                                          .normal, // Teks normal untuk nama lainnya
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
                            SizedBox(height: 1.h),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 7.h),
                poiniman_C.add_poin(
                    task: "poin_task10", poin: 0.002, text: "+2", seconds: 60)
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
                      dismissKeyboard();
                      easyThrottle(
                        handler: () {
                          controller.checkSend(
                              text: controller.textController.text,
                              nama: user.nama,
                              idUser: user.idUser,
                              noHp: user.username,
                              imageUser: session_C.fotoprofil,
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
      );
    });
  }
}

class CustomBottomSheet extends StatelessWidget {
  final Radio_Controller controller;
  CustomBottomSheet(
      {required this.controller}); // Konstruktor menerima controller
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Tinggi bottom sheet
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16), // Radius sudut atas
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Pengaturan Live Radio",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),

          // List Pengaturan
          Expanded(
            child: ListView(
              children: [
                // Pengaturan 1
                Container(
                  height: 40, // Atur tinggi secara manual
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 0), // Kurangi padding
                    title: Text(
                      "Mode Gelap",
                      style: TextStyle(fontSize: 14), // Sesuaikan ukuran font
                    ),
                    trailing: Obx(() {
                      return Switch(
                        value: controller.isDarkModeEnabled.value,
                        onChanged: (value) {
                          controller.isDarkModeEnabled.value = value;
                        },
                      );
                    }),
                  ),
                ),

                // Pengaturan 2
                ListTile(
                  title: Text("Mode Gelap"),
                  trailing: Obx(() {
                    return Switch(
                      value: controller.isDarkModeEnabled.value,
                      onChanged: (value) {
                        controller.isDarkModeEnabled.value = value;
                      },
                    );
                  }),
                ),

                // Pengaturan 3
                ListTile(
                  title: Text("Aktifkan Auto Play"),
                  trailing: Obx(() {
                    return Switch(
                      value: controller.isAutoPlayEnabled.value,
                      onChanged: (value) {
                        controller.isAutoPlayEnabled.value = value;
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
