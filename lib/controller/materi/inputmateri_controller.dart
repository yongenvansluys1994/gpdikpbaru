import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';

import 'package:gpdikpbaru/common/push_notification/push_notif_topic.dart';
import 'package:gpdikpbaru/controller/admin/data_berita_controller.dart';
import 'package:gpdikpbaru/controller/materi/materi_controller.dart';

import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/loader3.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class inputMateriController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nama_file;
  var selectedKategori = 'Ibadah'.obs;
  late RxString file_url = ''.obs;

  String BASE_URL_APP = ApiAuth.BASE_URL_APP;

  File? image;
  XFile? imageFile = null;
  final _pathFile = "".obs;
  String get pathFile => _pathFile.value;

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
    if (nama_file.text.trim().isNotEmpty) {
      // Do something with your input text
      print(nama_file.text.trim());

      // bring focus back to the input field
      Future.delayed(Duration.zero, () {
        focusNode.requestFocus();
        nama_file.clear();
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

  void filePicker(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Hanya file PDF yang diizinkan
    );

    if (result != null) {
      _pathFile.value = result.files.single.path!;
      update(); // Perbarui UI
    } else {
      RawSnackbar_bottom(
        message: "File tidak dipilih",
        kategori: "error",
        duration: 1,
      );
    }
  }

  void _openGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    image = File(pickedFile!.path);
    _pathFile.value = pickedFile.path;
    update();
    Get.back();
  }

  void _openCameraGereja() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );

    image = File(pickedFile!.path);
    _pathFile.value = pickedFile.path;
    update();
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nama_file = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    nama_file.dispose();
  }

  void hapusisi() {
    nama_file.clear();
    _pathFile.value = "";
    image = null;
    file_url.value = "";
  }

  CheckInput({required String aksi, required String id_kegiatan}) async {
    if (nama_file.text.isEmpty) {
      RawSnackbar_bottom(
        message: "Nama Materi harus diisi",
        kategori: "error",
        duration: 1,
      );
    } else if (aksi == "input") {
      if (pathFile.isEmpty) {
        RawSnackbar_bottom(
          message: "File Materi harus diunggah",
          kategori: "error",
          duration: 1,
        );
      } else {
        Get.showOverlay(
          asyncFunction: () => input(),
          loadingWidget: Loader(),
        );
      }
    }
  }

  input() async {
    GetLoader(); // Tampilkan loader
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${ApiAuth.BASE_API_ONLINE}materi/store"),
      );

      // Tambahkan field untuk nama file PDF
      request.fields['nm_pdf'] = nama_file.text;
      request.fields['base_url_app'] = BASE_URL_APP;
      request.fields['kategori'] = selectedKategori.value; // Tambahkan kategori

      // Tambahkan file PDF
      var pdfFile = await http.MultipartFile.fromPath("image", pathFile);
      request.files.add(pdfFile);

      // Kirim request
      var response = await request.send();

      final respStr = await response.stream.bytesToString();
      //logInfo("${jsonEncode(respStr)}");
      final res = json.decode(respStr);

      if (res['success']) {
        Get.back(); // Tutup loader
        Get.back(); // Tutup bottomsheet

        // Clear materiList dan fetch data baru
        final materiController = Get.find<Materi_Controller>();
        materiController.materiList.clear(); // Kosongkan list
        materiController.currentPage.value = 1; // Reset halaman ke 1
        materiController.hasReachedMax.value =
            false; // Reset indikator pagination
        await materiController.fetchMateri(); // Fetch data baru

        Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1,
        );

        sendPushMessage_topic(
            "all",
            "Materi Baru ditambahkan : ${nama_file.text}",
            "Klik untuk melihat Informasi detail Materi",
            "");
        hapusisi(); // Reset input
      } else {
        Get.back(); // Tutup loader
        RawSnackbar_bottom(
          message: res['message'],
          kategori: "error",
          duration: 1,
        );
      }
    } catch (e) {
      Get.back(); // Tutup loader
      RawSnackbar_bottom(
        message: "Terjadi kesalahan: $e",
        kategori: "error",
        duration: 1,
      );
    }
  }

  edit({required String id_kegiatan}) async {
    GetLoader();
    var request = await http.MultipartRequest(
        "POST", Uri.parse("${ApiAuth.EDIT_BERITA}/$id_kegiatan"));
    request.fields['nm_pdf'] = "${nama_file.text}";
    request.fields['base_url_app'] = BASE_URL_APP;

    if (pathFile != "") {
      var pic = await http.MultipartFile.fromPath("image", pathFile);
      request.files.add(pic);
    }
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
      var duration = const Duration(seconds: 1);
      sleep(duration);
      final ReloadData = Get.find<Berita_Controller>();
      await ReloadData.refresh();
    } else {
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  void delete(String id_kegiatan) async {
    GetLoader();
    var response =
        await http.get(Uri.parse("${ApiAuth.HAPUS_BERITA}/${id_kegiatan}"));
    var res = await jsonDecode(response.body);
    if (res['success']) {
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);
      var duration = const Duration(seconds: 1);
      sleep(duration);
      final ReloadData = Get.find<Berita_Controller>();
      await ReloadData.refresh();
      Get.back();
    } else {
      Get.back();
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }
}
