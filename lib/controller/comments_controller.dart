import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';
import 'package:gpdikpbaru/widgets/getdialog.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';

class Comments_Controller extends GetxController {
  late TextEditingController textController;
  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = true.obs;
  final _id = 0.obs;
  final _id_user = 0.obs;
  final _parent = "".obs;
  final _likes = 0.obs;
  final _ownlikes = 0.obs;

  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;
  int get id => _id.value;
  int get id_user => _id_user.value;
  String get parent => _parent.value;
  int get likes => _likes.value;
  int get ownlikes => _ownlikes.value;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  RxList data_comments = RxList([]);

  @override
  void onInit() async {
    super.onInit();
    textController = TextEditingController();
    collectionReference = firebaseFirestore.collection("comments");
  }

  Stream<List> getAllData() => collectionReference
      .where("id", whereIn: [id])
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((query) => query.docs.map((item) => (item)).toList());

  CheckSend(
      {required String id,
      required String parent,
      required String text,
      required String nama,
      required String id_user,
      required String image_user,
      required String lencana}) {
    if (textController.text.isEmpty) {
      RawSnackbar_top(
          message: "Pesan tidak boleh kosong", kategori: "error", duration: 1);
    } else {
      SendChat(
          text: text,
          parent: parent,
          id: id,
          nama: nama,
          id_user: id_user,
          image_user: image_user,
          lencana: lencana);
    }
  }

  Future SendChat(
      {required String id,
      required String parent,
      required String text,
      required String nama,
      required String id_user,
      required String image_user,
      required String lencana}) async {
    String postID = FirebaseFirestore.instance.collection('comments').doc().id;
    final docUser =
        FirebaseFirestore.instance.collection('comments').doc(postID);

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
      hapusisi();
      FocusManager.instance.primaryFocus?.unfocus();
      final poinIman = Get.find<poiniman_controller>();
      poinIman.updatepoinmanual(task: "poin_task6", point: 0.005, text: "+5");
    }).catchError((error) {
      RawSnackbar_top(
          message: "Gagal Mengirim Chat", kategori: "error", duration: 1);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    textController.dispose();
  }

  void hapusisi() {
    textController.clear();
  }

//ini adalah act pertama kali jika controller dibuka
  void changevalue({required id, required id_user, required parent}) {
    _id.value = id;
    _id_user.value = id_user;
    _parent.value = parent;
    //setelah value ID dikirim data chat akan di fetch
    data_comments.bindStream(getAllData());
    fetchLikes();
    fetchOwnLikes();
  }

  void fetchLikes() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('likes')
        .where("id", whereIn: [id]).get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    _likes.value = _myDocCount.length;
  }

  void fetchOwnLikes() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('likes')
        .where("id", whereIn: [id])
        .where("id_user", isEqualTo: id_user)
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    _ownlikes.value = _myDocCount.length;
  }

  Future<bool> addLikes(bool isLiked) async {
    String postID = FirebaseFirestore.instance.collection('likes').doc().id;
    final docUser = FirebaseFirestore.instance.collection('likes').doc(postID);

    final json = {
      'postID': postID,
      'parent': parent,
      'id': id,
      'id_user': id_user,
      'createdAt': FieldValue.serverTimestamp(),
    };
    if (isLiked == false) {
      await docUser.set(json).whenComplete(() {
        print("berhasil chat");
        //hapus textfield ketika berhasil
        hapusisi();
        final poinIman = Get.find<poiniman_controller>();
        poinIman.updatepoinmanual(task: "poin_task6", point: 0.005, text: "+5");
        //tutup keyboard ketika berhasil
        FocusManager.instance.primaryFocus?.unfocus();
      }).catchError((error) {
        getDialog("Kesalahan Internet", "Gagal Mengirim Likes");
      });
    } else {}

    return !isLiked;
  }
}
