import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';
import 'package:gpdikpbaru/widgets/getdialog.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Radio_Controller extends GetxController with WidgetsBindingObserver {
  // Dependencies
  final home_controller2 sessionC = Get.find();

  var isNotificationEnabled = false.obs; // Status notifikasi
  var isDarkModeEnabled = false.obs; // Status mode gelap
  var isAutoPlayEnabled = false.obs; // Status auto play
  // Pagination Variables
  DocumentSnapshot? lastDocument; // Dokumen terakhir yang dimuat
  bool isLoadingMore = false; // Status untuk memuat lebih banyak data
  var hasMoreData = true.obs; // Status untuk memeriksa apakah masih ada data

  // Data Live Chat
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('radiochat');
  var data_livechat = <Map<String, dynamic>>[].obs;

  // Scroll Controller
  final ScrollController scrollController = ScrollController();

  // Totals Online Viewers
  late String userId;
  late DatabaseReference userRef;
  StreamSubscription? onlineSubscription;
  var onlineUsers = <String>[].obs; // Daftar nama pengguna online

  // Observables
  RxInt totalOnline = 0.obs;
  var isEmpty = false.obs;
  var isFailed = false.obs;
  var isLoading = true.obs;
  var idUser = 0.obs;
  var judulRadio = "".obs;
  var urlRadio = "".obs;
  var statusRadio = false.obs;

  // Text Controller
  late TextEditingController textController;

  // Youtube Player
  YoutubePlayerController? youtubeController;
  bool isPlayerReady = false;
  var isYoutubeControllerReady = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize userId and Firebase references
    userId = '${sessionC.items[0].username}';
    textController = TextEditingController();

    // Stream radio data and check time
    streamRadio();
    checkWaktu();

    // Add lifecycle observer
    WidgetsBinding.instance.addObserver(this);

    // Initialize Firebase Realtime Database
    final db = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: '${ApiAuth.dbRealtime}',
    );

    userRef = db.ref('totals_online/$userId');

    // Set online status and listen to online users
    _setOnlineStatus();
    _listenToOnlineUsers();

    // Kirim pesan otomatis saat pengguna bergabung
    //sendJoinMessage(sessionC.items[0].nama);
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

  // Set online status in Firebase Realtime Database
  void _setOnlineStatus() {
    print("Calling _setOnlineStatus for userId: $userId");
    userRef.set({
      'online': true,
      'timestamp': ServerValue.timestamp,
      'name': sessionC.items[0].nama, // Tambahkan nama pengguna
    }).then((_) {
      print("Online status set successfully for userId: $userId");
    }).catchError((error) {
      print("Failed to set online status for userId: $userId. Error: $error");
    });

    userRef.onDisconnect().remove().then((_) {
      print("onDisconnect set successfully for userId: $userId");
    }).catchError((error) {
      print("Failed to set onDisconnect for userId: $userId. Error: $error");
    });
  }

  // Listen to online users
  void _listenToOnlineUsers() {
    final onlineRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: '${ApiAuth.dbRealtime}',
    ).ref('totals_online');

    onlineRef.onValue.listen((event) {
      final data = event.snapshot.value;
      print("🔥 Data received from Firebase: $data");

      if (data is Map) {
        // Filter pengguna yang online dan ambil nama mereka
        final users = data.values
            .where((user) => user is Map && user['online'] == true)
            .map((user) => user['name'] as String)
            .toList();

        // Simpan daftar nama pengguna yang online
        onlineUsers.assignAll(users); // Perbarui daftar nama pengguna
        totalOnline.value = users.length; // Perbarui jumlah pengguna online
      } else {
        print("Data is not a valid Map: $data");
        onlineUsers.clear(); // Kosongkan daftar jika data tidak valid
        totalOnline.value = 0;
      }
    });
  }

  void sendJoinMessage(String nama) {
    String postID = FirebaseFirestore.instance.collection('radiochat').doc().id;
    final docUser =
        FirebaseFirestore.instance.collection('radiochat').doc(postID);

    final json = {
      'postID': postID,
      'id_user': '1',
      'nama': "Moderator",
      'no_hp': '0000', // Kosongkan jika tidak diperlukan
      'text': "$nama Bergabung ke Radio Rohani",
      'image_user':
          'https://cdn-icons-png.flaticon.com/512/8550/8550692.png', // Kosongkan jika tidak ada gambar
      'lencana': '7.png', // Kosongkan jika tidak ada lencana
      'createdAt': FieldValue.serverTimestamp(),
    };

    docUser.set(json).then((_) {
      print("$nama Bergabung ke Radio Rohani");
    }).catchError((error) {
      print("Failed to send join message: $error");
    });
  }

  // Handle app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setOnlineStatus(); // Set online status when app is resumed
    } else if (state == AppLifecycleState.paused) {
      logInfo("App paused, updating last seen status");
      // Update last seen when app is paused
      userRef.update({'online': false, 'last_seen': ServerValue.timestamp});
    }
  }

  // Check if it's time for a specific event
  void checkWaktu() {
    DateTime currentTime = DateTime.now();
    if ((currentTime.weekday == JamIbadah.IbadahMinggu_hari &&
            currentTime.hour >= JamIbadah.IbadahMinggu_start &&
            currentTime.hour <= JamIbadah.IbadahMinggu_end) ||
        (currentTime.weekday == JamIbadah.IbadahPelprap_hari &&
            currentTime.hour >= JamIbadah.IbadahPelprap_start &&
            currentTime.hour <= JamIbadah.IbadahPelprap_end)) {
      AlertWaktu(menu: "Radio");
      update();
    }
  }

  // Stream radio data from Firestore
  void streamRadio() {
    FirebaseFirestore.instance
        .collection("radio")
        .doc("radio")
        .snapshots()
        .listen((snap) {
      if (snap.exists) {
        judulRadio.value = snap['judul'];
        urlRadio.value = snap['url'];
        statusRadio.value = snap['status'] == "0" ? false : true;

        print("URL Radio Updated: ${urlRadio.value}");

        // Initialize YoutubePlayerController if not already initialized
        if (youtubeController == null) {
          initializeYoutubePlayer();
        } else {
          // Update video if youtubeController is already initialized
          youtubeController!.load(urlRadio.value);
        }

        update();
      }
    });
  }

  // Initialize YoutubePlayerController
  void initializeYoutubePlayer() {
    print("Initializing YoutubePlayerController with URL: ${urlRadio.value}");
    youtubeController = YoutubePlayerController(
      initialVideoId: urlRadio.value,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: true,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(() {
        if (isPlayerReady && youtubeController!.value.isFullScreen) {
          // Additional logic if needed
        }
      });

    isYoutubeControllerReady.value = true;
  }

  // Validate and send chat
  void checkSend({
    required String text,
    required String nama,
    required String noHp,
    required String idUser,
    required String imageUser,
    required String lencana,
  }) {
    if (textController.text.isEmpty) {
      RawSnackbar_top(
          message: "Pesan tidak boleh kosong", kategori: "error", duration: 1);
    } else {
      sendChat(
        text: text,
        nama: nama,
        noHp: noHp,
        idUser: idUser,
        imageUser: imageUser,
        lencana: lencana,
      );
    }
  }

  // Send chat to Firestore
  Future<void> sendChat({
    required String text,
    required String nama,
    required String idUser,
    required String noHp,
    required String imageUser,
    required String lencana,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String postID = FirebaseFirestore.instance.collection('radiochat').doc().id;
    final docUser =
        FirebaseFirestore.instance.collection('radiochat').doc(postID);

    final json = {
      'postID': postID,
      'id_user': idUser,
      'nama': nama,
      'no_hp': noHp,
      'text': text,
      'image_user': imageUser,
      'lencana': lencana,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await docUser.set(json).then((_) {
      print("Chat sent successfully");
      clearText();
      final poinIman = Get.find<poiniman_controller>();
      poinIman.updatepoinmanual(task: "poin_task11", point: 0.001, text: "+1");
    }).catchError((error) {
      RawSnackbar_top(
          message: "Gagal Mengirim Chat", kategori: "error", duration: 1);
    });
  }

  // Clear text field
  void clearText() {
    textController.clear();
  }

  @override
  void onClose() {
    textController.dispose();
    // Batalkan listener Firebase
    onlineSubscription?.cancel();

    // Perbarui status pengguna menjadi offline
    userRef.update({'online': false, 'last_seen': ServerValue.timestamp}).then(
        (_) {
      print("User status updated to offline");
    }).catchError((error) {
      print("Failed to update user status: $error");
    });

    // Hapus observer lifecycle
    WidgetsBinding.instance.removeObserver(this);

    // Panggil super.onClose
    super.onClose();
  }

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

  void listenToLiveChat() {
    collectionReference
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((querySnapshot) {
      logInfo("Listener triggered: ${querySnapshot.docs.length} documents");
      if (querySnapshot.docs.isNotEmpty) {
        data_livechat.assignAll(querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
        logInfo("Live chat updated: ${querySnapshot.docs.length} chats");
      } else {
        data_livechat.clear();
        print("No live chat data found");
      }
    });
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
}
