import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/widgets/getdialog.dart';

import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  late TextEditingController R_namaController,
      R_tanggalController,
      R_nikController,
      R_passwordController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    R_namaController = TextEditingController();
    R_tanggalController = TextEditingController();
    R_nikController = TextEditingController();
    R_passwordController = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    R_namaController.dispose();
    R_tanggalController.dispose();
    R_nikController.dispose();
    R_passwordController.dispose();
  }

  void changevaluetanggal({required formattedDate}) {
    R_tanggalController.text = formattedDate;
  }

  CheckRegister() {
    if (R_namaController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Nama harus di isi", kategori: "error", duration: 1);
    } else if (R_nikController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "NIK harus di isi", kategori: "error", duration: 1);
    } else if (R_passwordController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Password harus di isi", kategori: "error", duration: 1);
    } else {
      signup();
    }
  }

  InputRumahTask(String username) async {
    final docUser = FirebaseFirestore.instance
        .collection('data_user')
        .doc(username)
        .collection('task')
        .doc(username);

    final json = {
      'username': 'id_user',
      'nm_task1': 'Registrasi Akun',
      'poin_task1': "1",
      'nm_task2': 'Baca Alkitab',
      'poin_task2': "0.000",
      'nm_task3': 'Nonton Ibadah Live Streaming',
      'poin_task3': "0.000",
      'nm_task4': 'Baca Renungan Harian',
      'poin_task4': "0.000",
      'nm_task5': 'Melakukan Persembahan Online',
      'poin_task5': "0.000",
      'nm_task6': 'Memberi Like di Postingan',
      'poin_task6': "0.000",
      'nm_task7': 'Memberi Komentar di Postingan',
      'poin_task7': "0.000",
      'nm_task8': 'Partisipasi Live Chat',
      'poin_task8': "0.000",
      'nm_task9': 'Main Games',
      'poin_task9': "0.000",
      'nm_task10': 'Membuka Jadwal Ibadah',
      'poin_task10': "0.000",
      'nm_task11': 'Mendengar Radio Rohani',
      'poin_task11': "0.000",
      'createdAt': FieldValue.serverTimestamp(),
    };
    await docUser.set(json).whenComplete(() {
      print("berhasil");
    }).catchError((error) {
      RawSnackbar_top(
          message: "Gagal Membuat Task", kategori: "error", duration: 1);
    });
  }

  signup() async {
    EasyLoading.show(status: "Loading...");
    try {
      // Insert to Firebase user
      String id = R_nikController.text;
      final docUser =
          FirebaseFirestore.instance.collection('data_user').doc(id);

      final json = {
        'nama': "${R_namaController.text}",
        'image_url': "https://cdn-icons-png.flaticon.com/512/149/149071.png",
        'tgl_lahir': "${R_tanggalController.text}",
        'alamat': '',
        'jenkel': 'L',
        'no_hp': '${R_nikController.text}',
        'email': '',
        'lencana': '1.png',
        'postID': id,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await docUser.set(json).whenComplete(() async {
        // Insert to database user
        var response = await http.post(Uri.parse(ApiAuth.REGISTER), body: {
          "name": R_namaController.text,
          "username": R_nikController.text,
          "password": R_passwordController.text,
          "confirm_password": R_passwordController.text,
          "level": "user",
          "tgl_lahir": R_tanggalController.text,
          "jenkel": "L",
          "image_url": "https://cdn-icons-png.flaticon.com/512/149/149071.png",
        });

        var res = await jsonDecode(response.body);

        if (res['success']) {
          InputRumahTask(R_nikController.text);
          EasyLoading.dismiss();
          Get.back();
          Snackbar_top(
              title: "Sukses",
              message: res['message'],
              kategori: "success",
              duration: 1);
          if (res['data']['event']) {
            getDefaultDialogFix(
                "Selamat anda mendapatkan Pulsa dari Event 10 Pendaftaran Akun Tercepat. Login sekarang ke aplikasi dan dapatkan hadiah pulsa",
                "winning");
          }
        } else {
          throw Exception(res['message']); // Lempar error jika tidak sukses
        }
      });
    } catch (e) {
      // Tangani error dan tampilkan pesan
      EasyLoading.dismiss();
      RawSnackbar_bottom(message: e.toString(), kategori: "error", duration: 1);
    } finally {
      // Pastikan EasyLoading selalu di-dismiss
      EasyLoading.dismiss();
    }
  }
}
