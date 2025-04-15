import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/common/push_notification/push_notif_topic.dart';
import 'package:gpdikpbaru/common/shared_prefs.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';
import 'package:gpdikpbaru/models/model_persembahan.dart';
import 'package:gpdikpbaru/widgets/getdialog.dart';
import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/loader2.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';

class Persembahan_Controller extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController namaController, nominalController;

  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = true.obs;
  final _pathImage = "".obs;
  final _fileNameImage = "".obs;
  final _imageRenungan = "".obs;
  final _imageUrl = "".obs;
  final _sessionusername = "".obs;
  final _sessionnama = "".obs;
  final _prevaluebank = "".obs;
  final _valuebank = "".obs;

  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;
  String get pathImage => _pathImage.value;
  String get fileNameImage => _fileNameImage.value;
  String get imageRenungan => _imageRenungan.value;
  String get imageUrl => _imageUrl.value;
  String get sessionusername => _sessionusername.value;
  String get sessionnama => _sessionnama.value;
  String get prevaluebank => _prevaluebank.value;
  String get valuebank => _valuebank.value;

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  late CollectionReference collectionReferenceDetail;
  late CollectionReference collectionReferencebank;

  RxList<ModelPersembahan> data_persembahan = RxList<ModelPersembahan>([]);
  RxList<ModelPersembahan> data_persembahanDetail =
      RxList<ModelPersembahan>([]);
  RxList data_bank = RxList([]);
  ModelPersembahan item(int index) => data_persembahan[index];

  @override
  void onInit() async {
    super.onInit();
    namaController = TextEditingController();
    nominalController = TextEditingController();
    var shared = await SharedPrefs().getUser();
    var response = json.decode(shared);
    logInfo(jsonEncode(response['username']));
    _sessionusername.value = response['username'];
    _sessionnama.value = response['nama'];

    collectionReference = firebaseFirestore.collection("data_persembahan");
    collectionReferenceDetail =
        firebaseFirestore.collection("data_persembahan");
    collectionReferencebank = firebaseFirestore.collection("data_bank");

    data_persembahan
        .bindStream(getAllEmployees(username: response['username']));
    ever(data_persembahan, (persembahan) {
      // ignore: unnecessary_null_comparison
      if (data_persembahan == null) {
      } else {
        data_bank.bindStream(getBank(bank: data_persembahan[0].bank));
      }
    });
  }

  Stream<List<ModelPersembahan>> getAllEmployees({required username}) =>
      collectionReference
          .where("user", whereIn: [username])
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((query) => query.docs
              .map((item) => ModelPersembahan.fromMap(item))
              .toList());

  Stream<List> getBank({required bank}) => collectionReferencebank
      .where("postID", whereIn: [bank])
      .snapshots()
      .map((query) => query.docs.map((item) => (item)).toList());

  Future<void> _openCameraGereja() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    _pathImage.value = result!.files.single.path!;
    _fileNameImage.value = result.files.single.name;
    _imageRenungan.value = result.files.single.path!;
  }

  Future<void> showMyDialog(
      {required String? postID,
      required BuildContext context,
      String? user_nama}) async {
    return Get.defaultDialog(
      title: "Upload Bukti Transfer :",
      content: Container(
          child: Column(
        children: [
          Form(
            key: formKey,
            child: Container(
              width: 90.w,
              height: 22.h,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Obx(() => Container(
                            width: 33.w,
                            height: 11.h,
                            child: (_imageRenungan.value == "")
                                ? Image.asset("assets/images/default-img.png")
                                : Image.file(File(_imageRenungan.value)),
                          )),
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['png', 'jpg', 'jpeg'],
                            );

                            _pathImage.value = result!.files.single.path!;
                            _fileNameImage.value = result.files.single.name;
                            _imageRenungan.value = result.files.single.path!;
                            print(imageRenungan);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 64, 64, 64)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.camera_alt, size: 20),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Pilih Gambar',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
      actions: <Widget>[
        SizedBox(
          width: 40.w,
          child: OutlinedButton.icon(
              //Handle button press event
              onPressed: () {
                pathImage == ""
                    ? getDialog("Error", "Bukti Pembayaran belum dipilih")
                    : KirimData(
                        context: context, postID: postID, user_nama: user_nama);
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: lightBlueColor,
                  width: 1,
                ),
                onPrimary: lightBlueColor,
              ),
              icon: const Icon(Icons.save_alt),
              label: const Text("Upload Bukti")),
        ),
        TextButton(
          child: const Text('Batalkan'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future KirimData(
      {required BuildContext context,
      required String? postID,
      String? user_nama}) async {
    Loader2(context);

    var storageImage = FirebaseStorage.instance
        .ref()
        .child("persembahan/${postID}/${fileNameImage}");
    File file = File(pathImage);
    try {
      await storageImage.putFile(file);
      _imageUrl.value = await storageImage.getDownloadURL();
    } catch (error) {
      print("Error");
    }
    //update data pembayaran di firebase dan mengubah status menjadi 1
    FirebaseFirestore.instance
        .collection('data_persembahan')
        .doc('${postID}')
        .update({
      'bukti_bayar': imageUrl,
      'status': "1",
    }).whenComplete(() {
      final poin_iman = Get.find<poiniman_controller>();
      poin_iman.updatepoinmanual(task: "poin_task5", point: 0.050, text: "+50");
      // Close the dialog programmatically
      Navigator.pop(context);
      Navigator.pop(context);
      //Akhir Loading Disini -------------------------------------

      sendPushMessage_topic(
          "admin",
          "Persembahan Online Masuk dari ${user_nama}",
          "Segera Periksa bukti pembayaran untuk mengkonfirmasinya di menu Admin data Persembahan!",
          "");
      getDefaultDialogFix("Berhasil Upload Bukti Transfer", "success");
      hapusbukti();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namaController.dispose();
    nominalController.dispose();
  }

  void hapusisi() {
    namaController.clear();
    nominalController.clear();
  }

  void hapusbukti() {
    _pathImage.value = "";
    _imageRenungan.value = "";
  }

  void changeprevaluebank({required prevaluebank}) {
    _prevaluebank.value = prevaluebank;
  }

  void changevaluebank({required String valuebank}) {
    _valuebank.value = valuebank;
  }

  CheckTambah(String nama, String nominal, String docId, int addEditFlag) {
    if (namaController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Nama harus di isi", kategori: "error", duration: 1);
    } else if (nominalController.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Nominal harus di isi", kategori: "error", duration: 1);
    } else {
      Get.showOverlay(
          asyncFunction: () => tambah(nama, nominal, docId, addEditFlag),
          loadingWidget: Loader());
    }
  }

  tambah(String nama, String nominal, String docId, int addEditFlag) async {
    if (addEditFlag == 1) {
      String id =
          FirebaseFirestore.instance.collection('data_persembahan').doc().id;
      final docUser =
          FirebaseFirestore.instance.collection('data_persembahan').doc(id);

      final json = {
        'nama': nama,
        'nominal': int.parse(nominal.replaceAll(',', '')),
        'bank': valuebank,
        'postID': id,
        'user': sessionusername,
        'user_nama': sessionnama,
        'status': "0",
        'bukti_bayar': "",
        'createdAt': FieldValue.serverTimestamp(),
      };
      await docUser.set(json).whenComplete(() {
        hapusisi();
        Get.back();
        Snackbar_top(
            title: "Sukses",
            message: "Berhasil Menambah Kolekte",
            kategori: "success",
            duration: 1);
      }).catchError((error) {
        RawSnackbar_top(
            message: "Gagal Menambah Data", kategori: "error", duration: 1);
      });
    }
  }

  Future<void> loadDetail({required postID}) async {
    data_persembahanDetail.bindStream(getAllEmployeesDetail(postID: postID));
    ever(data_persembahanDetail, (persembahanDetail) {
      // ignore: unnecessary_null_comparison
      if (data_persembahanDetail == null) {
        _isFailed.value = true;
        _isLoading.value = false;
      } else {
        if (data_persembahanDetail.isEmpty) {
          print("isempty");
          //data kosong
          _isEmpty.value = true;
          _isLoading.value = false;
        } else {
          //berhasil load
          data_bank.bindStream(getBank(bank: data_persembahan[0].bank));
          update();
          _isEmpty.value = false;

          _isLoading.value = false;
        }
        _isFailed.value = false;
        _isLoading.value = false;
      }
    });
  }

  Stream<List<ModelPersembahan>> getAllEmployeesDetail({required postID}) =>
      collectionReference.where("postID", whereIn: [postID]).snapshots().map(
          (query) => query.docs
              .map((item) => ModelPersembahan.fromMap(item))
              .toList());
}
