import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/shared_prefs.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';
import 'package:gpdikpbaru/widgets/dismiss_keyboard.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';

class CommentsWartaController extends GetxController {
  // Controllers
  late TextEditingController textController;

  // Reactive Variables
  final isEmpty = false.obs;
  final isFailed = false.obs;
  final isLoading = true.obs;
  final id = 0.obs;
  int idUser = 0;
  final parent = "".obs;

  // Firebase
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference commentsCollection;
  RxList dataComments = RxList([]);

  @override
  void onInit() async {
    super.onInit();
  }

  void firstRun({required int id, required String parent}) async {
    textController = TextEditingController();
    commentsCollection = firebaseFirestore.collection("comments_warta");
    this.id.value = id; // Gunakan .value
    this.parent.value = parent; // Gunakan .value
    logInfo("ID Jadwal: $id, Parent: $parent");

    var shared = await SharedPrefs().getUser();
    var response = json.decode(shared);
    idUser = int.parse(response['id_user']); // Gunakan .value
    logInfo("ID_USER : ${response['id_user'].toString()}");
    dataComments.bindStream(getAllData());
  }

  // Fetch all comments for a specific ID
  Stream<List> getAllData() {
    return commentsCollection
        .where("id", isEqualTo: id.value)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((query) => query.docs.map((item) => item).toList());
  }

  // Check and send a comment
  void checkAndSend({
    required String id,
    required String parent,
    required String text,
    required String nama,
    required String id_user,
    required String image_user,
    required String lencana,
  }) {
    if (textController.text.isEmpty) {
      RawSnackbar_top(
        message: "Pesan tidak boleh kosong",
        kategori: "error",
        duration: 1,
      );
    } else {
      sendComment(
        id: id,
        parent: parent,
        text: text,
        nama: nama,
        id_user: id_user,
        image_user: image_user,
        lencana: lencana,
      );
    }
  }

  // Send a comment to Firestore
  Future sendComment(
      {required String id,
      required String parent,
      required String text,
      required String nama,
      required String id_user,
      required String image_user,
      required String lencana}) async {
    String postID =
        FirebaseFirestore.instance.collection('comments_warta').doc().id;
    final docUser =
        FirebaseFirestore.instance.collection('comments_warta').doc(postID);

    final json = {
      'postID': postID,
      'parent': parent,
      'id': int.parse(id),
      'id_user': id_user,
      'nama': nama,
      'text': text,
      'image_user': image_user,
      'lencana': lencana,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await docUser.set(json).whenComplete(() {
      print("berhasil chat");
      final poinIman = Get.find<poiniman_controller>();
      poinIman.updatepoinmanual(task: "poin_task7", point: 0.005, text: "+5");
      clearTextField();
    }).catchError((error) {
      RawSnackbar_top(
          message: "Gagal Mengirim Chat", kategori: "error", duration: 1);
    });
  }

  // Clear text field
  void clearTextField() {
    textController.clear();
  }

  @override
  void onClose() {
    // textController.dispose();
    super.onClose();
  }
}
