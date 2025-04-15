import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';

import 'package:gpdikpbaru/common/push_notification/push_notif_topic.dart';
import 'package:gpdikpbaru/controller/admin/data_live_controller.dart';

import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/loader3.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:http/http.dart' as http;

class inputLiveController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController judul_liveCon, url_liveCon;

  String BASE_URL_APP = ApiAuth.BASE_URL_APP;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    judul_liveCon = TextEditingController();
    url_liveCon = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    judul_liveCon.dispose();
    url_liveCon.dispose();
  }

  void hapusisi() {
    judul_liveCon.clear();
    url_liveCon.clear();
  }

  CheckInput({required String aksi, required String id_khotbah}) async {
    if (judul_liveCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Judul harus di isi", kategori: "error", duration: 1);
    } else if (url_liveCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Isi harus di isi", kategori: "error", duration: 1);
    } else {
      if (aksi == "edit") {
        edit(
          id_khotbah: id_khotbah,
        );
      } else {
        input();
      }
    }
  }

  input() async {
    EasyLoading.show();
    var request =
        await http.MultipartRequest("POST", Uri.parse(ApiAuth.INPUT_LIVE));
    request.fields['judul_live'] = "${judul_liveCon.text}";
    request.fields['url_live'] = "${url_liveCon.text}";

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

      sendPushMessage_topic("all", "${judul_liveCon.text}",
          "Klik untuk Menonton Ibadah Live Streaming", "");
      hapusisi();
      final ReloadData = Get.find<Live_Controller>();
      await ReloadData.refresh();
    } else {
      EasyLoading.dismiss();
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  edit({required String id_khotbah}) async {
    EasyLoading.show();
    var request = await http.MultipartRequest(
        "POST", Uri.parse("${ApiAuth.EDIT_LIVE}/$id_khotbah"));
    request.fields['judul_live'] = "${judul_liveCon.text}";
    request.fields['url_live'] = "${url_liveCon.text}";

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    final res = json.decode(respStr);
    if (res['success']) {
      EasyLoading.dismiss();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);
      final ReloadData = Get.find<Live_Controller>();
      await ReloadData.refresh();
    } else {
      EasyLoading.dismiss();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  void delete(String id_khotbah) async {
    GetLoader();
    var response =
        await http.get(Uri.parse("${ApiAuth.HAPUS_LIVE}/${id_khotbah}"));
    var res = await jsonDecode(response.body);
    if (res['success']) {
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);
      final ReloadData = Get.find<Live_Controller>();
      await ReloadData.refresh();
    } else {
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }
}
