import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gpdikpbaru/common/push_notification/push_notif_topic.dart';
import 'package:gpdikpbaru/common/shared_prefs.dart';
import 'package:gpdikpbaru/controller/profil/p_iman_controller.dart';
import 'package:gpdikpbaru/models/model_profil.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/widgets/logger.dart';

import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_store/open_store.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/api.dart';

class home_controller2 extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation = AlwaysStoppedAnimation(0); // Nilai default
  var utilitasData = {}.obs;
  var infoJemaat = {}.obs; // Map untuk menyimpan data jemaat
  var birthdays = [].obs; // List untuk ulang tahun
  var eventsToday = [].obs;
  var birthdayText = "".obs;
  var nextEventText = "".obs;
  var jadwals = [].obs; // List untuk jadwal ibadah
  int indexUltah = 0; // Untuk tracking indeks

  final _items = <ModelProfil>[].obs;
  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = false.obs;
  final _tokenfirebase = "".obs;
  final _alertberanda = "".obs;
  final _session_iduser = 0.obs;
  final _fotoprofil = "".obs;
  final _lencana = "".obs;

  home_controller2();

  List<ModelProfil> get items => _items.toList();

  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;
  String get tokenfirebase => _tokenfirebase.value;
  String get alertberanda => _alertberanda.value;
  int get session_iduser => _session_iduser.value;
  String get fotoprofil => _fotoprofil.value;
  String get lencana => _lencana.value;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  final Uri _urldeleteakun =
      Uri.parse('http://yongen-bisa.com/bapenda_app/request_delete.php');

  final storage = GetStorage();
  var newContentList = <dynamic>[].obs;
  var badgeStatus = <String, bool>{}.obs;
  var radioStatus = false.obs; // Observable boolean
  var liveStatus = false.obs;

  @override
  void onInit() async {
    await init();
    await fetchInfoJemaat();
    await checkLatestVersion();
    if (utilitasData['auto_push_notification'] == 1) {
      sendDailyNotification();
    }
    //checkinternet();
    fetchAndAppendNewContent();
    super.onInit();

    getAlert();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(); // Animasi berulang

    animation = Tween<double>(begin: 0, end: 1).animate(controller);

    // Dengarkan perubahan status radio secara real-time
    FirebaseFirestore.instance
        .collection("radio")
        .doc("radio")
        .snapshots()
        .listen((DocumentSnapshot snap) {
      if (snap.exists) {
        radioStatus.value = snap['status'] == "0" ? false : true;
        logInfo("Radio status updated: ${radioStatus.value}");
      } else {
        logInfo("Document does not exist.");
      }
    });
  }

  Future<void> sendDailyNotification() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      // Panggil endpoint Laravel untuk memeriksa status
      final response = await http.post(
        Uri.parse("${ApiAuth.BASE_API_ONLINE}auth/checkmarknotification"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        // Jika backend mengembalikan bahwa notifikasi belum dikirim
        if (eventsToday.isNotEmpty) {
          // Iterasi melalui setiap event di eventsToday
          for (var event in eventsToday) {
            String kategori = event['kategori'] ?? "Ibadah";
            String tanggalIbadah = event['tanggal_ibadah'] ?? "Hari ini";
            String jamIbadah = event['jam'] ?? " ";

            // Kirim notifikasi untuk setiap event
            sendPushMessage_topic(
              "all", // Topik untuk semua user
              "Pemberitahuan : ${kategori}", // Judul notifikasi
              "Bpk/Ibu Jemaat yang terkasih, Jangan lupa untuk menghadiri $kategori pada Hari ini $tanggalIbadah pukul $jamIbadah. Tuhan Yesus memberkati.", // Isi notifikasi
              "", // Deskripsi tambahan
            );
          }

          logInfo("Notifikasi harian berhasil dikirim untuk semua event.");
        } else {
          logInfo(
              "Tidak ada event hari ini, tidak ada notifikasi yang dikirim.");
        }
      } else {
        // Jika backend mengembalikan bahwa notifikasi sudah dikirim
        logInfo(
            "Notifikasi sudah dikirim hari ini: ${responseData['message']}");
      }
    } catch (e) {
      logInfo("Error saat memeriksa atau mengirim notifikasi: $e");
    }
  }

  Future<void> FetchlaunchUrl() async {
    if (!await launchUrl(_urldeleteakun)) {
      throw Exception('Could not launch $_urldeleteakun');
    }
  }

  void startBirthdayAnimation() {
    if (birthdays.isEmpty) return;

    int indexUltah = 0; // Indeks untuk mengganti nama

    Timer.periodic(Duration(seconds: 4), (timer) {
      if (indexUltah >= birthdays.length) {
        indexUltah = 0; // Kembali ke nama pertama jika sudah sampai akhir
      }

      birthdayText.value = birthdays[indexUltah]["name"] ?? "Unknown";
      indexUltah++; // Geser ke nama berikutnya
    });
  }

  Future<void> fetchInfoJemaat() async {
    try {
      final response = await http
          .post(Uri.parse("${ApiAuth.BASE_API_ONLINE}auth/infojemaat"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        final data = jsonData["original"]["data"];

        infoJemaat.value = data;
        birthdays.assignAll(data["BirhdayWeeks"] ?? []);
        eventsToday.assignAll(data["jadwals_hariini"] ?? []);
        //logInfo(jsonEncode(eventsToday));
        if (birthdays.isNotEmpty) {
          startBirthdayAnimation();
        }
        jadwals.assignAll(data["jadwals_mingguinilimit1"] ?? []);
        nextEventText.value =
            "${jadwals[0]["kategori"]} - ${jadwals[0]["tanggal_ibadah"]} Pkl. ${jadwals[0]["jam"]}";
        //logInfo(jsonEncode(jadwals));
      } else {}
    } catch (e) {
      logInfo("Error fetching data: $e");
    }
  }

  Future<void> checkLatestVersion() async {
    try {
      var response = await http.get(Uri.parse(ApiAuth.CEK_UTILITAS));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['success'] == true && jsonResponse['data'] is List) {
          var appData =
              jsonResponse['data'][0]; // Ambil elemen pertama dari data

          utilitasData.value = appData;

          int dbVersion = appData["version"] is int
              ? appData["version"]
              : int.parse(appData["version"].toString());

          if (dbVersion > ApiAuth.APP_VERSION) {
            Get.dialog(
              barrierDismissible: false,
              AlertDialog(
                title: Text("Update Baru!"),
                content: Text(
                    'Versi Terbaru 1.$dbVersion Aplikasi telah tersedia, Versi Anda sekarang adalah 1.${ApiAuth.APP_VERSION}'),
                actions: [
                  TextButton(
                    child: Text("Update"),
                    onPressed: () {
                      OpenStore.instance.open(
                        androidAppBundleId: 'com.yongenbisa.philadelphia2',
                      );
                    },
                  ),
                ],
              ),
            );
          }
        }
      } else {
        logInfo("Gagal fetch data: ${response.statusCode}");
      }
    } catch (e) {
      logInfo("Error checking version: $e");
    }
  }

  fetchfotouser({required String username}) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("data_user")
        .doc(username)
        .get();
    logInfo(jsonEncode(snap['image_url']));
    _fotoprofil.value = snap['image_url'];
    _lencana.value = snap['lencana'];
  }

  getuserToken({required String username}) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(username)
        .get();
    _tokenfirebase.value = snap['token'];
    print(tokenfirebase);
  }

  getAlert() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("alert_beranda")
        .doc("1")
        .get();
    _alertberanda.value = snap['judul'];
    print(alertberanda);
  }

  Future<void> refresh2() async {
    _items.clear();
    await init();
  }

  Future<void> init() async {
    await loadPage();
  }

  Future<void> loadPage() async {
    if (!isLoading) {
      _isLoading.value = true;

      final items = await ApiAuth.fetchdatauser();
      if (items == null) {
        //data tidak ada
        _isFailed.value = true;
      } else {
        if (items.isEmpty) {
          //data kosong
          _isEmpty.value = true;
        } else {
          //berhasil load
          _items.addAll(items);
          getuserToken(username: items[0].username);
          fetchfotouser(username: items[0].username);
          _isEmpty.value = false;
          final ProsesIman = Get.find<p_iman_controller>();
          ProsesIman.proses_p_iman();
        }
        _isFailed.value = false;
      }
      _isLoading.value = false;
    }
  }

  Future<void> refresh() async {
    _items.clear();
  }

  Future<void> checkinternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Online! mobile");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Online! wifi");
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      print("Online! ethernet");
    } else if (connectivityResult == ConnectivityResult.vpn) {
      print("Online! vpn");
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      print("Online! bluetooth");
    } else if (connectivityResult == ConnectivityResult.other) {
      print("Online! other");
    } else if (connectivityResult == ConnectivityResult.none) {
      RawSnackbar_bottom(
          message: "Tidak ada Internet, Periksa Jaringan",
          kategori: "error",
          duration: 7);
    }
  }

  void logout() async {
    await SharedPrefs().removeUser();
    Get.offAllNamed(GetRoutes.login);
  }

  String dateFormatter(DateTime date) {
    dynamic dayData =
        '{ "1" : "Senin", "2" : "Selasa", "3" : "Rabu", "4" : "Kamis", "5" : "Jumat", "6" : "Sabtu", "7" : "Minggu" }';

    dynamic monthData =
        '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "Mei", "6" : "Juni", "7" : "Jul", "8" : "Ags", "9" : "Sep", "10" : "Okt", "11" : "Nov", "12" : "Des" }';

    return json.decode(dayData)['${date.weekday}'] +
        ", " +
        date.day.toString() +
        " " +
        json.decode(monthData)['${date.month}'] +
        " " +
        date.year.toString();
  }

  Future<void> fetchAndAppendNewContent() async {
    // Ambil data lama dari GetStorage
    List<dynamic> existingData = storage.read<List>('new_content') ?? [];
    final existingIds = existingData.map((e) => e['id']).toSet();

    try {
      final response = await http.get(
        Uri.parse('${ApiAuth.BASE_API_ONLINE}new_content/'),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        if (result['success'] == true && result['data'] is List) {
          List<dynamic> fetchedData = result['data'];

          // Filter hanya data baru berdasarkan id
          List<dynamic> newItems = fetchedData
              .where((item) => !existingIds.contains(item['id']))
              .toList();

          if (newItems.isNotEmpty) {
            List<dynamic> updatedData = [...existingData, ...newItems];
            storage.write('new_content', updatedData);
            newContentList.assignAll(updatedData);
            print('✅ ${newItems.length} konten baru ditambahkan ke storage.');
            logInfo(jsonEncode(newContentList));

            // Proses badge setelah data diperbarui
            processBadgeStatus(updatedData);
          } else {
            print('ℹ️ Tidak ada konten baru.');
            newContentList.assignAll(existingData);
            logInfo(jsonEncode(existingData));

            // Proses badge dengan data lama
            processBadgeStatus(existingData);
          }
        }
      } else {
        print('❌ Gagal fetch dari server: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error fetch: $e');
    }
  }

  // Fungsi untuk memproses status badge per kategori
  void processBadgeStatus(List<dynamic> data) {
    // Reset badgeStatus
    badgeStatus.clear();

    // Proses data untuk setiap kategori
    for (var item in data) {
      String kategori = item['kategori'];
      bool isRead = item['is_read'].toString() == "false";

      // Jika kategori belum ada di badgeStatus, tambahkan
      if (!badgeStatus.containsKey(kategori)) {
        badgeStatus[kategori] = isRead;
      } else {
        // Jika sudah ada, pastikan badge tetap true jika ada is_read == false
        badgeStatus[kategori] = badgeStatus[kategori]! || isRead;
      }
      logInfo("${badgeStatus['renungan']}");
    }
  }

  void markKategoriAsRead(String kategori) {
    final box = GetStorage();
    List<dynamic> data =
        box.read<List>('new_content') ?? []; // Ambil data dari storage

    // Periksa apakah ada item dengan kategori yang cocok
    bool kategoriDitemukan = data.any((item) => item['kategori'] == kategori);

    if (!kategoriDitemukan) {
      print('⚠️ Tidak ada item dengan kategori "$kategori" di new_content.');
      return; // Keluar dari fungsi jika kategori tidak ditemukan
    }

    // Jika kategori ditemukan, tandai sebagai dibaca
    List<dynamic> updated = data.map((item) {
      if (item['kategori'] == kategori) {
        item['is_read'] = 'true'; // Tandai sebagai dibaca
      }
      return item;
    }).toList();

    box.write('new_content', updated); // Simpan data yang diperbarui
    newContentList.assignAll(updated); // Perbarui observable
    processBadgeStatus(updated); // Proses badge status
    print('✅ Kategori "$kategori" berhasil ditandai sebagai dibaca.');
    logInfo(jsonEncode(newContentList));
  }

  void clearNewContentStorage() {
    storage.remove('new_content');
    newContentList.clear();
    print('🗑️ Storage "new_content" berhasil dihapus.');
  }
}
