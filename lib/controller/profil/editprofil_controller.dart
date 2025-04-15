import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';

import 'package:gpdikpbaru/widgets/getdialog.dart';

import 'package:gpdikpbaru/widgets/loader3.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class editprofil_controller extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController namaCon,
      tglCon,
      alamatCon,
      jenisCon,
      notelpCon,
      emailCon;

  File? image; // File gambar yang dipilih
  final _pathImage = "".obs;
  final _fileNameImage = "".obs;
  final _imageUrl = "".obs;
  final _imageUrlnow = "".obs;

  final _asdasdas = "".obs;
  String get pathImage => _pathImage.value;
  String get imageUrl => _imageUrl.value;
  String get imageUrlnow => _imageUrlnow.value;
  String get fileNameImage => _fileNameImage.value;
  String get asdasdas => _asdasdas.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    namaCon = TextEditingController();
    tglCon = TextEditingController();
    alamatCon = TextEditingController();
    jenisCon = TextEditingController();
    notelpCon = TextEditingController();
    emailCon = TextEditingController();
    fetchdatauser();
  }

  Future<void> fetchdatauser() async {
    final fetchuser = Get.find<home_controller2>();
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("data_user")
        .doc(fetchuser.items[0].username)
        .get();
    namaCon.text = snap['nama'];
    tglCon.text = snap['tgl_lahir'];
    alamatCon.text = snap['alamat'];
    jenisCon.text = snap['jenkel'];
    notelpCon.text = snap['no_hp'];
    emailCon.text = snap['email'];
    _imageUrlnow.value = snap['image_url'];
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    namaCon.dispose();
    tglCon.dispose();
    alamatCon.dispose();
    jenisCon.dispose();
    notelpCon.dispose();
    emailCon.dispose();
  }

  void hapusisi() {
    namaCon.clear();
    tglCon.clear();
    alamatCon.clear();
    jenisCon.clear();
    notelpCon.clear();
    emailCon.clear();
    _pathImage.value = "";
  }

  Future<void> openCameraGereja() async {
    // Pilih gambar menggunakan ImagePicker
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
      _fileNameImage.value = pickedFile.name;

      print("Image Path: ${_pathImage.value}");
      print("Image Name: ${_fileNameImage.value}");
    } else {
      print("No image selected");
    }

    update();
  }

  CheckSimpan({required String id_user, required String username}) async {
    if (namaCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Judul harus di isi", kategori: "error", duration: 1);
    } else {
      edit(id_user: id_user, username: username);
    }
  }

  edit({required String id_user, required String username}) async {
    GetLoader();
    //end edit data firebase data_user
    var storageImage = FirebaseStorage.instance
        .ref()
        .child("foto_user/${username}/${fileNameImage}");
    File file = File(pathImage);
    try {
      await storageImage.putFile(file);
      _imageUrl.value = await storageImage.getDownloadURL();
    } catch (error) {
      print("Error");
    }
    //update data pembayaran di firebase dan mengubah status menjadi 1
    FirebaseFirestore.instance
        .collection('data_user')
        .doc('${username}')
        .update({
      'nama': "${namaCon.text}",
      'image_url': "${pathImage == "" ? imageUrlnow : imageUrl}",
      'tgl_lahir': "${tglCon.text}",
      'alamat': '${alamatCon.text}',
      'jenkel': '${jenisCon.text}',
      'no_hp': '${notelpCon.text}',
      'email': '${emailCon.text}'
    }).whenComplete(
      () async {
        //update semua image & lencana chat comments
        WriteBatch batch = FirebaseFirestore.instance.batch();
        FirebaseFirestore.instance
            .collection("livechat")
            .where("no_hp", whereIn: ['${username}'])
            .get()
            .then((querySnapshot) {
              querySnapshot.docs.forEach((document) {
                batch.update(document.reference, {
                  "image_user": "${pathImage == "" ? imageUrlnow : imageUrl}"
                });
              });
              return batch.commit();
            });
        WriteBatch batch2 = FirebaseFirestore.instance.batch();
        FirebaseFirestore.instance
            .collection("comments")
            .where("id_user", whereIn: ['${id_user}'])
            .get()
            .then((querySnapshot) {
              querySnapshot.docs.forEach((document) {
                batch2.update(document.reference, {
                  "image_user": "${pathImage == "" ? imageUrlnow : imageUrl}"
                });
              });
              return batch2.commit();
            });
      },
    );
    //end edit data firebase data_user

    //edit data database user
    var request = await http.MultipartRequest(
        "POST", Uri.parse("${ApiAuth.EDIT_PROFIL}/$id_user"));
    request.fields['nama'] = "${namaCon.text}";
    request.fields['username'] = "${notelpCon.text}";

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    final res = json.decode(respStr);
    if (res['success']) {
      Get.back();
      getDefaultDialogtoHome("Profil Berhasil Disimpan", "success", 2);
    } else {
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
    //end edit data database user
  }
}
