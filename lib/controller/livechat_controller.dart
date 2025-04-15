import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';

class Livechat_Controller extends GetxController {
  // Firestore Collection Reference
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('radiochat');

  // Pagination Variables
  DocumentSnapshot? lastDocument; // Dokumen terakhir yang dimuat
  bool isLoadingMore = false; // Status untuk memuat lebih banyak data
  var hasMoreData = true.obs; // Status untuk memeriksa apakah masih ada data

  // Data Live Chat
  var data_livechat = <Map<String, dynamic>>[].obs;

  // Scroll Controller
  final ScrollController scrollController = ScrollController();

  // Text Controller untuk input chat
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // Listener untuk mendeteksi scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("Reached bottom of chat");
        loadMoreData(); // Muat lebih banyak data saat mencapai akhir scroll
      }
    });

    // Ambil data awal
    getInitialData();
  }

  @override
  void onClose() {
    // Bersihkan controller saat tidak digunakan
    scrollController.dispose();
    textController.dispose();
    super.onClose();
  }

  // Fungsi untuk mengambil data awal
  Future<void> getInitialData({int limit = 15}) async {
    try {
      final query = collectionReference
          .orderBy('createdAt', descending: true)
          .where('createdAt',
              isNotEqualTo: null) // hanya ambil yang sudah punya timestamp
          .limit(limit);

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last; // Simpan dokumen terakhir
        data_livechat.assignAll(querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
        print("Initial data loaded: ${querySnapshot.docs.length} chats");
      } else {
        hasMoreData.value = false; // Tidak ada data lagi
        print("No initial data found");
      }
    } catch (e) {
      print("Error fetching initial data: $e");
    }
  }

  // Fungsi untuk memuat lebih banyak data
  Future<void> loadMoreData({int limit = 20}) async {
    if (isLoadingMore || !hasMoreData.value || lastDocument == null) {
      print(
          "Skip loading: isLoadingMore=$isLoadingMore, hasMoreData=${hasMoreData.value}, lastDocument=$lastDocument");
      return;
    }

    isLoadingMore = true;

    try {
      final query = collectionReference
          .orderBy('createdAt', descending: true)
          .where('createdAt', isNotEqualTo: null)
          .startAfterDocument(lastDocument!)
          .limit(limit);

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last; // Simpan dokumen terakhir
        data_livechat.addAll(querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
        print("Loaded more data: ${querySnapshot.docs.length} chats");
      } else {
        hasMoreData.value = false; // Tidak ada data lagi
        print("No more data to load");
      }
    } catch (e) {
      print("Error loading more data: $e");
    }

    isLoadingMore = false;
  }

  // Fungsi untuk mengirim pesan
  Future<void> CheckSend({
    required String text,
    required String nama,
    required String id_user,
    required String no_hp,
    required String image_user,
    required String lencana,
  }) async {
    if (text.isEmpty) return; // Jangan kirim pesan kosong

    try {
      String postID = collectionReference.doc().id;
      final docUser = collectionReference.doc(postID);

      final json = {
        'postID': postID,
        'id_user': id_user,
        'nama': nama,
        'no_hp': no_hp,
        'text': text,
        'image_user': image_user,
        'lencana': lencana,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await docUser.set(json);
      textController.clear(); // Bersihkan input setelah mengirim pesan
      await fetchNewestChat(); // <<=== Tambahkan ini
      final poinIman = Get.find<poiniman_controller>();
      poinIman.updatepoinmanual(task: "poin_task8", point: 0.005, text: "+5");
      print("Message sent: $text");
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  // Fungsi ini ambil 1 chat terbaru setelah kirim pesan
  Future<void> fetchNewestChat() async {
    try {
      final query = await collectionReference
          .orderBy('createdAt', descending: true)
          .where('createdAt', isNotEqualTo: null)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final latestChat = query.docs.first.data() as Map<String, dynamic>;

        // Cek apakah chat sudah ada di list
        final isExist = data_livechat.any((chat) =>
            chat['postID'] != null && chat['postID'] == latestChat['postID']);

        if (!isExist) {
          data_livechat.insert(
              0, latestChat); // Tambahkan ke paling atas (karena reverse)
          print("Newest chat inserted");
        }
      }
    } catch (e) {
      print("Error fetching newest chat: $e");
    }
  }
}
