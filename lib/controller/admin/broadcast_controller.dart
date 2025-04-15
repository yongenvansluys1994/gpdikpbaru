import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gpdikpbaru/common/push_notification/push_notif_single.dart';

import 'package:gpdikpbaru/common/push_notification/push_notif_topic.dart';

import 'package:gpdikpbaru/widgets/getdialog.dart';
import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/logger.dart';

import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class broadcast_Controller extends GetxController {
  late String username;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController judulController, isiController;

  File? image;
  final _pathImage = "".obs;
  String get pathImage => _pathImage.value;

  final _selected = "user".obs;
  String get selected => _selected.value;

  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = true.obs;
  final _fileNameImage = "".obs;
  final _imageRenungan = "".obs;
  final _imageUrl = "".obs;
  final _prevaluebank = "".obs;
  final _valuebank = "".obs;

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
    isiController = TextEditingController();
    username = Get.arguments['username'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    judulController.dispose();
    isiController.dispose();
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

  CheckTambah(String kategori) {
    if (judulController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Judul harus di isi", kategori: "error", duration: 1);
    } else if (isiController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Isi harus di isi", kategori: "error", duration: 1);
    } else {
      Get.showOverlay(
          asyncFunction: () => tambah(kategori), loadingWidget: Loader());
    }
  }

  tambah(String kategori) async {
    sendPushMessage_topic(
        "${kategori}", "${judulController.text}", "${isiController.text}", "");
    Get.back();
    getDefaultDialog("Berhasil Menyimpan Data", "success", 2);
    hapusisi();
  }

  testing() async {
    var userToken = ''.obs;

    DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection("UserTokens")
        .doc(username)
        .get();

    if (document.exists) {
      // Extract the token from the document
      String? token = document.data()?['token'];
      if (token != null) {
        userToken.value = token; // Store the token in the observable
        sendPushMessage(userToken.value, "Testing Pesan Notifikasi",
            "Pesan Berhasil diterima", "");
        // sendPushMessage_topic(
        //     "all", "Testing Pesan Notifikasi", "Pesan Berhasil diterima", "");
      } else {
        print("Token not found in the document.");
      }
    } else {
      print("Document with nik $username does not exist.");
    }
  }

  void hapusisi() {
    judulController.clear();
    isiController.clear();
    _pathImage.value = "";
    image = null;
  }

  void changevalue({required String value}) {
    _selected.value = value;
  }
}
