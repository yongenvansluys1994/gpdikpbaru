import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:gpdikpbaru/widgets/getdialog.dart';
import 'package:gpdikpbaru/widgets/loader.dart';

import 'package:gpdikpbaru/widgets/snackbar.dart';

class alertBeranda_Controller extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController judulController;

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
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    judulController.dispose();
  }

  CheckTambah() {
    if (judulController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Judul harus di isi", kategori: "error", duration: 1);
      _status5.value = false;
    } else {
      Get.showOverlay(
          asyncFunction: () => SimpanData(), loadingWidget: Loader());
    }
  }

  SimpanData() async {
    FirebaseFirestore.instance.collection('alert_beranda').doc('1').update({
      'judul': judulController.text,
      'createdAt': FieldValue.serverTimestamp(),
    }).whenComplete(() {
      // sendPushMessage_topic(kategori, judulController.text, urlController.text);

      getDefaultDialog("Berhasil Menyimpan Data", "success", 2);

      hapusisi();
    });
  }

  void hapusisi() {
    judulController.clear();
  }

  void changevalue({required String value}) {
    _selected.value = value;
  }
}
