import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gpdikpbaru/widgets/getdialog.dart';

import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/loader2.dart';
import 'package:gpdikpbaru/widgets/loader3.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';

class Bank_Controller extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController namabankController,
      norekController,
      namarekController,
      carabayarController;

  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = true.obs;

  final _prevaluebank = "".obs;
  final _valuebank = "".obs;
  final _selectedjenis = "Bank".obs;
  String get selectedjenis => _selectedjenis.value;

  final _imageUrl = "".obs;
  final _pathImage = "".obs;
  final _fileNameImage = "".obs;
  final _imageRenungan = "".obs;
  String get imageUrl => _imageUrl.value;
  String get pathImage => _pathImage.value;
  String get fileNameImage => _fileNameImage.value;
  String get imageRenungan => _imageRenungan.value;

  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;

  String get prevaluebank => _prevaluebank.value;
  String get valuebank => _valuebank.value;

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  RxList data_bank = RxList([]);
  RxList data_bankDetail = RxList([]);
  item(int index) => data_bank[index];

  @override
  void onInit() async {
    super.onInit();

    namabankController = TextEditingController();
    norekController = TextEditingController();
    namarekController = TextEditingController();
    carabayarController = TextEditingController();

    collectionReference = firebaseFirestore.collection("data_bank");

    data_bank.bindStream(getAllEmployees());
  }

  Stream<List> getAllEmployees() => collectionReference
      .snapshots()
      .map((query) => query.docs.map((item) => (item)).toList());

  Future<void> openCameraGereja() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    _pathImage.value = result!.files.single.path!;
    _fileNameImage.value = result.files.single.name;
    _imageRenungan.value = result.files.single.path!;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namabankController.dispose();
    norekController.dispose();
    namarekController.dispose();
    carabayarController.dispose();
    _pathImage.value = "";
  }

  void hapusisi() {
    //hapus isi khusus firebase
    namabankController.clear();
    norekController.clear();
    namarekController.clear();
    carabayarController.clear();
    _pathImage.value = "";
  }

  void changeprevaluebank({required prevaluebank}) {
    _prevaluebank.value = prevaluebank;
  }

  void changevaluebank({required String valuebank}) {
    _valuebank.value = valuebank;
  }

  CheckInput(
      {required String aksi, required String postID, required image}) async {
    if (namabankController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Tanggal harus di isi", kategori: "error", duration: 1);
    } else if (norekController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "No Rek harus di isi", kategori: "error", duration: 1);
    } else if (namarekController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Nama Rek harus di isi", kategori: "error", duration: 1);
    } else if (carabayarController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Cara Bayar harus di isi", kategori: "error", duration: 1);
    } else if (aksi == "input") {
      Get.showOverlay(asyncFunction: () => input(), loadingWidget: Loader());
    } else if (aksi == "edit") {
      Get.showOverlay(
          asyncFunction: () => edit(postID: postID, image: image),
          loadingWidget: Loader());
    }
  }

  input() async {
    String id = FirebaseFirestore.instance.collection('data_bank').doc().id;
    final docUser = FirebaseFirestore.instance.collection('data_bank').doc(id);
    var storageImage = FirebaseStorage.instance
        .ref()
        .child("data_bank/${id}/${fileNameImage}");
    File file = File(pathImage);
    try {
      await storageImage.putFile(file);
      _imageUrl.value = await storageImage.getDownloadURL();
    } catch (error) {}
    final json = {
      'jenis': selectedjenis,
      'nama_bank': namabankController.text,
      'no_rek': norekController.text,
      'nama_rek': namarekController.text,
      'cara_bayar': carabayarController.text,
      'user': 'admin',
      'image': imageUrl,
      'postID': id,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await docUser.set(json).whenComplete(() {
      hapusisi();
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: "Berhasil Menambah Data",
          kategori: "success",
          duration: 1);
    }).catchError((error) {
      RawSnackbar_top(
          message: "Gagal Menambah Data", kategori: "error", duration: 1);
    });
  }

  edit({required String postID, required image}) async {
    if (pathImage != "") {
      var storageImage = FirebaseStorage.instance
          .ref()
          .child("data_bank/${postID}/${fileNameImage}");
      File file = File(pathImage);
      try {
        await storageImage.putFile(file);
        _imageUrl.value = await storageImage.getDownloadURL();
      } catch (error) {}
    }
    FirebaseFirestore.instance.collection('data_bank').doc('${postID}').update({
      'jenis': selectedjenis,
      'nama_bank': namabankController.text,
      'no_rek': norekController.text,
      'nama_rek': namarekController.text,
      'cara_bayar': carabayarController.text,
      'image': image,
      'status': "1",
    }).whenComplete(() {
      hapusisi();
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: "Berhasil Merubah Data",
          kategori: "success",
          duration: 1);
    }).catchError((error) {
      RawSnackbar_top(
          message: "Gagal Merubah Data", kategori: "error", duration: 1);
    });
  }

  delete({required String postID}) async {
    GetLoader();
    FirebaseFirestore.instance
        .collection("data_bank")
        .doc('${postID}')
        .delete()
        .whenComplete(() {
      hapusisi();
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: "Berhasil Hapus Data",
          kategori: "success",
          duration: 1);
    }).catchError((error) {
      RawSnackbar_top(
          message: "Gagal Hapus Data", kategori: "error", duration: 1);
    });
    ;
  }

  Future<void> Verifikasi(
      {String? postID, required BuildContext context}) async {
    Loader2(context);

    FirebaseFirestore.instance
        .collection('data_persembahan')
        .doc('${postID}')
        .update({'status': "2"}).whenComplete(() {
      //Akhir Loading Disini -------------------------------------
      // tutup loading & dialog confirm
      var duration = const Duration(seconds: 2);
      sleep(duration);
      Get.back();
      getDefaultDialogFix("Berhasil Verifikasi Pembayaran", "success");
    }).catchError((error) {
      getDefaultDialogFix("Gagal Verifikasi Pembayaran", "error");
    });
  }

  void changevalue({required String value}) {
    _selectedjenis.value = value;
  }
}
