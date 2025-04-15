import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';

import 'package:gpdikpbaru/common/push_notification/push_notif_topic.dart';

import 'package:gpdikpbaru/widgets/getdialog.dart';
import 'package:gpdikpbaru/widgets/loader.dart';

import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class radioAdmin_Controller extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController judulController, urlController;
  RxInt totalOnline = 0.obs;

  File? image;
  final _pathImage = "".obs;
  String get pathImage => _pathImage.value;

  final _status5 = false.obs;
  bool get status5 => _status5.value;
  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = true.obs;
  final _fileNameImage = "".obs;
  final _imageRenungan = "".obs;
  final _imageUrl = "".obs;
  final _prevaluebank = "".obs;
  final _valuebank = "".obs;

  final _selected = "user".obs;
  String get selected => _selected.value;

  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;
  String get fileNameImage => _fileNameImage.value;
  String get imageRenungan => _imageRenungan.value;
  String get imageUrl => _imageUrl.value;
  String get prevaluebank => _prevaluebank.value;
  String get valuebank => _valuebank.value;

  @override
  void onInit() async {
    super.onInit();
    judulController = TextEditingController();
    urlController = TextEditingController();
    stream_radio();
  }

  void clearAllOnlineUsers() {
    final onlineRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: '${ApiAuth.dbRealtime}',
    ).ref('totals_online');

    onlineRef.remove().then((_) {
      print("✅ All online users have been cleared.");
      totalOnline.value = 0; // Reset total online count
    }).catchError((error) {
      print("❌ Failed to clear online users: $error");
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    judulController.dispose();
    urlController.dispose();
  }

  stream_radio() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("radio").doc("radio").get();
    _status5.value = snap['status'] == "0" ? false : true;
  }

  Future<void> PilihPicker() {
    return Get.defaultDialog(
      title: "Choose option",
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Divider(
              height: 1,
              color: Colors.blue,
            ),
            ListTile(
              onTap: () {
                _openGallery();
              },
              title: Text("Gallery"),
              leading: Icon(
                Icons.account_box,
                color: Colors.blue,
              ),
            ),
            Divider(
              height: 1,
              color: Colors.blue,
            ),
            ListTile(
              onTap: () {
                _openCameraGereja();
              },
              title: Text("Camera"),
              leading: Icon(
                Icons.camera,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    image = File(pickedFile!.path);
    _pathImage.value = pickedFile.path;
    update();
    Get.back();
  }

  void _openCameraGereja() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );

    image = File(pickedFile!.path);
    _pathImage.value = pickedFile.path;
    update();
    Get.back();
  }

  CheckTambah(String kategori, bool value) {
    if (value == true) {
      if (judulController.text.isEmpty) {
        RawSnackbar_bottom(
            message: "Judul harus di isi", kategori: "error", duration: 1);
        _status5.value = false;
      } else if (urlController.text.isEmpty) {
        RawSnackbar_bottom(
            message: "Isi harus di isi", kategori: "error", duration: 1);
        _status5.value = false;
      } else {
        Get.showOverlay(
            asyncFunction: () => online(kategori, value),
            loadingWidget: Loader());
      }
    } else {
      Get.showOverlay(
          asyncFunction: () => offline(kategori, value),
          loadingWidget: Loader());
    }
  }

  online(String kategori, bool value) async {
    FirebaseFirestore.instance.collection('radio').doc('radio').update({
      'judul': judulController.text,
      'url': urlController.text,
      'status': value == false ? "0" : "1",
      'createdAt': FieldValue.serverTimestamp(),
    }).whenComplete(() {
      getDefaultDialog("Berhasil Menyimpan Data", "success", 2);

      sendPushMessage_topic(
          "all",
          "Radio Rohani Filadelfia Sedang Online!",
          "${judulController.text}, Yuk ikut dengarkan dan bisa request lagu!",
          "");
      hapusisi();
    });
  }

  offline(String kategori, bool value) async {
    FirebaseFirestore.instance.collection('radio').doc('radio').update({
      'judul': "",
      'url': "lCBJYm7mSNM",
      'status': value == false ? "0" : "1",
      'createdAt': FieldValue.serverTimestamp(),
    }).whenComplete(() {
      // sendPushMessage_topic(kategori, judulController.text, urlController.text);

      sendPushMessage_topic("all", "Radio Rohani Filadelfia Sudah Offline!",
          "Terima kasih telah mengikuti Radio Online Kami!", "");

      getDefaultDialog("Berhasil Menyimpan Data", "success", 2);
      clearAllOnlineUsers();
      hapusisi();
    });
  }

  void hapusisi() {
    judulController.clear();
    urlController.clear();
    _pathImage.value = "";
  }

  void changevalue({required String value}) {
    _selected.value = value;
  }

  void switch_button({required bool value, required String kategori}) {
    _status5.value = value;
    CheckTambah(kategori, value);
  }
}
