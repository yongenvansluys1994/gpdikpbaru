import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';

import 'package:gpdikpbaru/common/push_notification/push_notif_topic.dart';
import 'package:gpdikpbaru/controller/admin/data_renungan_controller.dart';

import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/loader3.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class inputRenunganController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController judul_renunganCon, isi_renunganCon;
  late RxString image_url = ''.obs;

  String BASE_URL_APP = ApiAuth.BASE_URL_APP;
  File? image;
  final _pathImage = "".obs;
  String get pathImage => _pathImage.value;

  late final focusNode = FocusNode(
    onKey: _handleKeyPress,
  );

  KeyEventResult _handleKeyPress(FocusNode focusNode, RawKeyEvent event) {
    // handles submit on enter
    if (event.isKeyPressed(LogicalKeyboardKey.enter) && !event.isShiftPressed) {
      _sendMessage();
      // handled means that the event will not propagate
      return KeyEventResult.handled;
    }
    // ignore every other keyboard event including SHIFT+ENTER
    return KeyEventResult.ignored;
  }

  void _sendMessage() {
    if (isi_renunganCon.text.trim().isNotEmpty) {
      // Do something with your input text
      print(isi_renunganCon.text.trim());

      // bring focus back to the input field
      Future.delayed(Duration.zero, () {
        focusNode.requestFocus();
        isi_renunganCon.clear();
      });
    }
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
    judul_renunganCon = TextEditingController();
    isi_renunganCon = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    judul_renunganCon.dispose();
    isi_renunganCon.dispose();
  }

  void hapusisi() {
    judul_renunganCon.clear();
    isi_renunganCon.clear();
    _pathImage.value = "";
    image = null;
    image_url.value = "";
  }

  CheckInput({required String aksi, required String id_renungan}) async {
    if (judul_renunganCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Judul harus di isi", kategori: "error", duration: 1);
    } else if (isi_renunganCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Isi harus di isi", kategori: "error", duration: 1);
    } else {
      if (aksi == "edit") {
        edit(
          id_renungan: id_renungan,
        );
      } else {
        if (pathImage == "") {
          RawSnackbar_bottom(
              message: "Gambar harus di upload",
              kategori: "error",
              duration: 1);
        } else {
          input();
        }
      }
    }
  }

  input() async {
    EasyLoading.show();
    var request =
        await http.MultipartRequest("POST", Uri.parse(ApiAuth.INPUT_RENUNGAN));
    request.fields['judul_renungan'] = "${judul_renunganCon.text}";
    request.fields['isi_renungan'] = "${isi_renunganCon.text}";
    request.fields['base_url_app'] = BASE_URL_APP;

    var pic = await http.MultipartFile.fromPath("image", pathImage);
    request.files.add(pic);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    final res = json.decode(respStr);
    if (res['success']) {
      EasyLoading.dismiss();

      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);

      sendPushMessage_topic("all", "${judul_renunganCon.text}",
          "Klik untuk melihat Renungan", "");
      hapusisi();
      final ReloadData = Get.find<Renungan_Controller>();
      await ReloadData.refresh();
    } else {
      EasyLoading.dismiss();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  edit({required String id_renungan}) async {
    EasyLoading.show();
    var request = await http.MultipartRequest(
        "POST", Uri.parse("${ApiAuth.EDIT_RENUNGAN}/$id_renungan"));
    request.fields['judul_renungan'] = "${judul_renunganCon.text}";
    request.fields['isi_renungan'] = "${isi_renunganCon.text}";
    request.fields['base_url_app'] = BASE_URL_APP;

    if (pathImage != "") {
      var pic = await http.MultipartFile.fromPath("image", pathImage);
      request.files.add(pic);
    }

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    final res = json.decode(respStr);
    if (res['success']) {
      EasyLoading.dismiss();
      hapusisi();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);
      final ReloadData = Get.find<Renungan_Controller>();
      await ReloadData.refresh();
    } else {
      EasyLoading.dismiss();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  void delete(String id_renungan) async {
    GetLoader();
    var response =
        await http.get(Uri.parse("${ApiAuth.HAPUS_RENUNGAN}/${id_renungan}"));
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
