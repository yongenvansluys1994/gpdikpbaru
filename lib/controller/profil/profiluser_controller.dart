import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gpdikpbaru/widgets/logger.dart';

import 'package:http/http.dart' as http;

class ProfilUserPageController extends GetxController {
  final storage = GetStorage();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  late int id;
  late String name;
  late String username;
  String fotoprofil = '';
  String lencana = '';
  int likes = 0;
  StreamSubscription<DocumentSnapshot>? _likesSubscription;
  List<Map<String, String>> badges = []; // List untuk menyimpan badge

  var _poin_iman1 = 0.0.obs;
  var _poin_iman2 = 0.0.obs;
  var _poin_iman3 = 0.0.obs;
  var _poin_iman4 = 0.0.obs;
  var _poin_iman5 = 0.0.obs;
  var _poin_iman6 = 0.0.obs;
  var _poin_iman7 = 0.0.obs;
  var _poin_iman8 = 0.0.obs;
  var _poin_iman9 = 0.0.obs;
  var _poin_iman10 = 0.0.obs;
  var _poin_iman11 = 0.0.obs;
  var _sumpoin = 0.0.obs;

  double get poin_iman1 => _poin_iman1.value;
  double get poin_iman2 => _poin_iman2.value;
  double get poin_iman3 => _poin_iman3.value;
  double get poin_iman4 => _poin_iman4.value;
  double get poin_iman5 => _poin_iman5.value;
  double get poin_iman6 => _poin_iman6.value;
  double get poin_iman7 => _poin_iman7.value;
  double get poin_iman8 => _poin_iman8.value;
  double get poin_iman9 => _poin_iman9.value;
  double get poin_iman10 => _poin_iman10.value;
  double get poin_iman11 => _poin_iman11.value;
  double get sumpoin => _sumpoin.value;

  RxList data_p_iman = RxList([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    id = arguments['id'];
    name = arguments['name'];
    username = arguments['username'];
    startLikesStream(username: username);
    fetchFirebaseUser(username: username);
    proses_p_iman();
    update();
  }

  fetchFirebaseUser({required String username}) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("data_user")
        .doc(username)
        .get();
    fotoprofil = snap['image_url'];
    lencana = snap['lencana'];
    update();
  }

  void startLikesStream({required String username}) {
    // Ambil username dari session atau tempat penyimpanan user saat ini

    // Set up stream ke document user
    _likesSubscription = FirebaseFirestore.instance
        .collection('data_user')
        .doc(username)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        // Update state with the latest likes count
        likes = snapshot.get('likes') ?? 0;
        update();
      } else {
        // Handle case where document doesn't exist
        likes = 0;
        update();
      }
    }, onError: (error) {
      print("Error listening to likes updates: $error");
    });
    update();
  }

  Future<void> incrementLikes(String username) async {
    try {
      // Ambil data likes dari storage
      Map<String, dynamic> likesData = storage.read('likes') ?? {};

      // Periksa apakah user sudah memberikan likes ke username ini hari ini
      String today = DateTime.now()
          .toIso8601String()
          .substring(0, 10); // Format: YYYY-MM-DD
      if (likesData[username] == today) {
        EasyLoading.showError(
            'Anda hanya dapat memberikan 1 like per hari untuk setiap profil');
        return;
      }

      // Jika belum, tambahkan likes
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('data_user').doc(username);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userRef);

        if (!snapshot.exists) {
          transaction.set(userRef, {'likes': 1});
        } else {
          int currentLikes = snapshot.get('likes') ?? 0;
          transaction.update(userRef, {'likes': currentLikes + 1});
        }
      });

      // Simpan data likes ke storage
      likesData[username] = today;
      storage.write('likes', likesData);

      EasyLoading.showSuccess('Berhasil Memberi Likes');
      update(); // Perbarui UI
    } catch (e) {
      print('Error incrementing likes: $e');
      EasyLoading.showError('Gagal memberikan likes');
    }
  }

  List<Map<String, String>> getDynamicBadges() {
    List<Map<String, String>> badges = [];

    if (data_p_iman.isNotEmpty) {
      var p_task1 = double.parse(data_p_iman[0]['poin_task1']);
      var p_task2 = double.parse(data_p_iman[0]['poin_task2']);
      var p_task3 = double.parse(data_p_iman[0]['poin_task3']);
      var p_task4 = double.parse(data_p_iman[0]['poin_task4']);
      var p_task5 = double.parse(data_p_iman[0]['poin_task5']);
      var p_task6 = double.parse(data_p_iman[0]['poin_task6']);
      var p_task7 = double.parse(data_p_iman[0]['poin_task7']);
      var p_task8 = double.parse(data_p_iman[0]['poin_task8']);
      var p_task9 = double.parse(data_p_iman[0]['poin_task9']);
      var p_task10 = double.parse(data_p_iman[0]['poin_task10']);
      var p_task11 = double.parse(data_p_iman[0]['poin_task11']);

      var nm_task1 = data_p_iman[0]['nm_task1'];
      var nm_task2 = data_p_iman[0]['nm_task2'];
      var nm_task3 = data_p_iman[0]['nm_task3'];
      var nm_task4 = data_p_iman[0]['nm_task4'];
      var nm_task5 = data_p_iman[0]['nm_task5'];
      var nm_task6 = data_p_iman[0]['nm_task6'];
      var nm_task7 = data_p_iman[0]['nm_task7'];
      var nm_task8 = data_p_iman[0]['nm_task8'];
      var nm_task9 = data_p_iman[0]['nm_task9'];
      var nm_task10 = data_p_iman[0]['nm_task10'];
      var nm_task11 = data_p_iman[0]['nm_task11'];

      if (p_task1 >= 1)
        badges.add({
          'task': 'p_task1',
          'badge': 'assets/badge/1.png',
          'name': nm_task1
        });
      logInfo(jsonEncode(badges));
      if (p_task2 >= 1)
        badges.add({
          'task': 'p_task2',
          'badge': 'assets/badge/2.png',
          'name': nm_task2
        });
      if (p_task3 >= 1)
        badges.add({
          'task': 'p_task3',
          'badge': 'assets/badge/3.png',
          'name': nm_task3
        });
      if (p_task4 >= 1)
        badges.add({
          'task': 'p_task4',
          'badge': 'assets/badge/4.png',
          'name': nm_task4
        });
      if (p_task5 >= 1)
        badges.add({
          'task': 'p_task5',
          'badge': 'assets/badge/5.png',
          'name': nm_task5
        });
      if (p_task6 >= 1)
        badges.add({
          'task': 'p_task6',
          'badge': 'assets/badge/6.png',
          'name': nm_task6
        });
      if (p_task7 >= 1)
        badges.add({
          'task': 'p_task7',
          'badge': 'assets/badge/7.png',
          'name': nm_task7
        });
      if (p_task8 >= 1)
        badges.add({
          'task': 'p_task8',
          'badge': 'assets/badge/8.png',
          'name': nm_task8
        });
      if (p_task9 >= 1)
        badges.add({
          'task': 'p_task9',
          'badge': 'assets/badge/9.png',
          'name': nm_task9
        });
      if (p_task10 >= 1)
        badges.add({
          'task': 'p_task10',
          'badge': 'assets/badge/10.png',
          'name': nm_task10
        });
      if (p_task11 >= 1)
        badges.add({
          'task': 'p_task11',
          'badge': 'assets/badge/11.png',
          'name': nm_task11
        });
    }
    this.badges = badges; // Perbarui variabel global badges
    update(); // Memperbarui UI

    return badges;
  }

  Future<void> proses_p_iman() async {
    collectionReference = firebaseFirestore
        .collection("data_user")
        .doc(username)
        .collection('task');
    data_p_iman.bindStream(getAllData());
    ever(data_p_iman, (p_iman) {
      // ignore: unnecessary_null_comparison
      if (data_p_iman == null) {
        print("null");
      } else {
        var p_task1 = double.parse(data_p_iman[0]['poin_task1']);
        var p_task2 = double.parse(data_p_iman[0]['poin_task2']);
        var p_task3 = double.parse(data_p_iman[0]['poin_task3']);
        var p_task4 = double.parse(data_p_iman[0]['poin_task4']);
        var p_task5 = double.parse(data_p_iman[0]['poin_task5']);
        var p_task6 = double.parse(data_p_iman[0]['poin_task6']);
        var p_task7 = double.parse(data_p_iman[0]['poin_task7']);
        var p_task8 = double.parse(data_p_iman[0]['poin_task8']);
        var p_task9 = double.parse(data_p_iman[0]['poin_task9']);
        var p_task10 = double.parse(data_p_iman[0]['poin_task10']);
        var p_task11 = double.parse(data_p_iman[0]['poin_task11']);

        _poin_iman1.value = p_task1 >= 0.950 && p_task1 < 1
            ? 0.9
            : double.parse(p_task1.toStringAsFixed(1));
        _poin_iman2.value = p_task2 >= 0.950 && p_task2 < 1
            ? 0.9
            : double.parse(p_task2.toStringAsFixed(1));
        _poin_iman3.value = p_task3 >= 0.950 && p_task3 < 1
            ? 0.9
            : double.parse(p_task3.toStringAsFixed(1));
        _poin_iman4.value = p_task4 >= 0.950 && p_task4 < 1
            ? 0.9
            : double.parse(p_task4.toStringAsFixed(1));
        _poin_iman5.value = p_task5 >= 0.950 && p_task5 < 1
            ? 0.9
            : double.parse(p_task5.toStringAsFixed(1));
        _poin_iman6.value = p_task6 >= 0.950 && p_task6 < 1
            ? 0.9
            : double.parse(p_task6.toStringAsFixed(1));
        _poin_iman7.value = p_task7 >= 0.950 && p_task7 < 1
            ? 0.9
            : double.parse(p_task7.toStringAsFixed(1));
        _poin_iman8.value = p_task8 >= 0.950 && p_task8 < 1
            ? 0.9
            : double.parse(p_task8.toStringAsFixed(1));
        _poin_iman9.value = p_task9 >= 0.950 && p_task9 < 1
            ? 0.9
            : double.parse(p_task9.toStringAsFixed(1));
        _poin_iman10.value = p_task10 >= 0.950 && p_task10 < 1
            ? 0.9
            : double.parse(p_task10.toStringAsFixed(1));
        _poin_iman11.value = p_task11 >= 0.950 && p_task11 < 1
            ? 0.9
            : double.parse(p_task11.toStringAsFixed(1));

        _sumpoin.value = p_task1 +
            p_task2 +
            p_task3 +
            p_task4 +
            p_task5 +
            p_task6 +
            p_task7 +
            p_task8 +
            p_task9 +
            p_task10 +
            p_task11;
        getDynamicBadges();
      }

      update();
    });
  }

// Fungsi untuk mendapatkan badge
  List<Map<String, String>> getBadges() {
    // Contoh data badge
    badges = [
      {'badge': 'assets/badge/1.png', 'name': 'Badge 1'},
      {'badge': 'assets/badge/2.png', 'name': 'Badge 2'},
      {'badge': 'assets/badge/3.png', 'name': 'Badge 3'},
    ];

    update(); // Memperbarui UI
    return badges;
  }

  Stream<List> getAllData() => collectionReference
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((query) => query.docs.map((item) => (item)).toList());

  @override
  void dispose() {
    // Batalkan subscription saat widget di-dispose untuk mencegah memory leak
    _likesSubscription?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
