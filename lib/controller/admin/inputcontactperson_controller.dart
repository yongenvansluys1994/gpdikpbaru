import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';

import 'package:gpdikpbaru/controller/admin/data_renungan_controller.dart';

import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/loader3.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class inputContactPersonController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController NamaCon, No_HPCon, AlamatCon, KetCon;
  late RxString image_url = ''.obs;

  String BASE_URL_APP = ApiAuth.BASE_URL_APP;
  File? image;
  final _pathImage = "".obs;
  String get pathImage => _pathImage.value;

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
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery, // Pilih dari galeri
      maxWidth: 800, // Set target width
      maxHeight: 800, // Set target height
      imageQuality: 50, // Set kualitas gambar (0-100)
    );

    if (pickedFile != null) {
      // Simpan path dan file gambar
      image = File(pickedFile.path);
      _pathImage.value = pickedFile.path;

      print("Image Path: ${_pathImage.value}");
    } else {
      print("No image selected");
    }
    update();
    Get.back();
  }

  void _openCameraGereja() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera, // Pilih dari galeri
      maxWidth: 800, // Set target width
      maxHeight: 800, // Set target height
      imageQuality: 50, // Set kualitas gambar (0-100)
    );

    if (pickedFile != null) {
      // Simpan path dan file gambar
      image = File(pickedFile.path);
      _pathImage.value = pickedFile.path;

      print("Image Path: ${_pathImage.value}");
    } else {
      print("No image selected");
    }
    update();
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    NamaCon = TextEditingController();
    No_HPCon = TextEditingController();
    AlamatCon = TextEditingController();
    KetCon = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    NamaCon.dispose();
    No_HPCon.dispose();
    AlamatCon.dispose();
    KetCon.dispose();
  }

  void hapusisi() {
    NamaCon.clear();
    No_HPCon.clear();
    AlamatCon.clear();
    KetCon.clear();
    _pathImage.value = "";
    image = null;
    image_url.value = "";
  }

  CheckInput({required String aksi, required int id}) async {
    if (NamaCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Nama harus di isi", kategori: "error", duration: 1);
    } else if (No_HPCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "No HP harus di isi", kategori: "error", duration: 1);
    } else if (AlamatCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Alamat harus di isi", kategori: "error", duration: 1);
    } else if (KetCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Keterangan/Jabatan harus di isi",
          kategori: "error",
          duration: 1);
    } else {
      if (aksi == "edit") {
        Get.showOverlay(
            asyncFunction: () => edit(
                  id: id,
                ),
            loadingWidget: Loader());
      } else {
        if (pathImage == "") {
          RawSnackbar_bottom(
              message: "Gambar harus di upload",
              kategori: "error",
              duration: 1);
        } else {
          Get.showOverlay(
              asyncFunction: () => input(), loadingWidget: Loader());
        }
      }
    }
  }

  input() async {
    var request = await http.MultipartRequest(
        "POST", Uri.parse(ApiAuth.INPUT_CONTACTPERSON));
    request.fields['nama'] = "${NamaCon.text}";
    request.fields['no_hp'] = "${No_HPCon.text}";
    request.fields['alamat'] = "${AlamatCon.text}";
    request.fields['ket'] = "${KetCon.text}";
    request.fields['base_url_app'] = BASE_URL_APP;

    var pic = await http.MultipartFile.fromPath("image", pathImage);
    request.files.add(pic);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    final res = json.decode(respStr);
    if (res['success']) {
      Get.back();
      hapusisi();
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);
      final ReloadData = Get.find<Renungan_Controller>();
      await ReloadData.refresh();
    } else {
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  edit({required int id}) async {
    var request = await http.MultipartRequest(
        "POST", Uri.parse("${ApiAuth.EDIT_CONTACTPERSON}/$id"));
    request.fields['nama'] = "${NamaCon.text}";
    request.fields['no_hp'] = "${No_HPCon.text}";
    request.fields['alamat'] = "${AlamatCon.text}";
    request.fields['ket'] = "${KetCon.text}";
    request.fields['base_url_app'] = BASE_URL_APP;

    if (pathImage != "") {
      var pic = await http.MultipartFile.fromPath("image", pathImage);
      request.files.add(pic);
    }

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    final res = json.decode(respStr);
    if (res['success']) {
      Get.back();
      hapusisi();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);
      final ReloadData = Get.find<Renungan_Controller>();
      await ReloadData.refresh();
    } else {
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  void delete(int id) async {
    GetLoader();
    var response =
        await http.get(Uri.parse("${ApiAuth.HAPUS_CONTACTPERSON}/$id"));
    var res = await jsonDecode(response.body);
    if (res['success']) {
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);
      final ReloadData = Get.find<Renungan_Controller>();
      await ReloadData.refresh();
    } else {
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }
}
