import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/models/model_profil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';

import 'package:http/http.dart' as http;

import '../../common/api.dart';

class Warta_Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation = AlwaysStoppedAnimation(0); // Nilai default
  var isLoading = true.obs; // Tambahkan ini
  var currentPage = 0.obs;
  var wartaItems = [].obs;
  var jadwalIbadah = {}.obs; // Store all categories' schedules
  var dataProfil = <ModelProfil>[].obs;

  var tglIbadahController = TextEditingController();
  var selectedImages = <File>[].obs;
  int? FirstIndex;

  String BASE_URL_APP = ApiAuth.BASE_URL_APP;

  @override
  void onInit() {
    super.onInit();
    generateWartaItems();
    dataProfil.add(Get.arguments as ModelProfil);

    scrollToCurrentWeek();
    Future.delayed(Duration.zero, () {
      fetchAllJadwal(currentPage.value); // Fetch jadwal for the current week
    });

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(); // Animasi berulang

    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  void generateWartaItems() {
    DateTime now = DateTime.now();
    List<Map<String, dynamic>> items = [];
    Set<String> addedWeeks = {}; // Gunakan set untuk memastikan minggu unik

    for (int month = 0; month < 12; month++) {
      if (month > now.month - 1) break;

      DateTime firstDay = DateTime(now.year, month + 1, 1);
      DateTime lastDay = DateTime(now.year, month + 2, 0);

      // Cari hari Senin pertama dari bulan ini
      DateTime current = firstDay;
      while (current.weekday != DateTime.monday) {
        current = current
            .subtract(Duration(days: 1)); // Mundur ke hari Senin sebelumnya
      }

      List<Map<String, DateTime>> weeks = [];

      // Iterasi per minggu (Senin-Minggu)
      while (current.isBefore(lastDay.add(Duration(days: 1)))) {
        DateTime weekEnd = current.add(Duration(days: 6)); // Minggu

        // Pastikan minggu hanya ditambahkan jika belum ada di daftar
        String weekKey =
            '${current.toIso8601String()}-${weekEnd.toIso8601String()}';
        if (!addedWeeks.contains(weekKey)) {
          if (weekEnd.month == month + 1 ||
              (current.month == month + 1 && weekEnd.month == month + 2)) {
            // Tambahkan minggu ini
            weeks.add({
              'startDate': current,
              'endDate': weekEnd,
            });
            addedWeeks.add(weekKey); // Tandai minggu ini sudah ditambahkan

            // Tambahkan logika untuk menghentikan setelah +1 minggu
            if (weekEnd.isAfter(DateTime.now())) {
              break; // Hentikan iterasi setelah menambahkan minggu tambahan
            }
          }
        }

        current = current.add(Duration(days: 7)); // Ke Senin berikutnya
      }

      for (int i = 0; i < weeks.length; i++) {
        var week = weeks[i];
        DateTime startDate = week['startDate']!;
        DateTime endDate = week['endDate']!;

        int weekNumber = i + 1; // Nomor minggu berdasarkan Minggu pertama
        String imageName = 'assets/images/warta-$weekNumber.png';

        items.add({
          'month': startDate.month - 1, // Bulan dimulai dari 0
          'week': weekNumber,
          'startDate': startDate,
          'endDate': endDate,
          'title': 'Warta Minggu ke-$weekNumber',
          'description': '''
Ini adalah warta jemaat untuk minggu ke-$weekNumber bulan ${_getIndonesianMonth(startDate.month)}.
Geser ke kiri untuk melihat warta minggu sebelumnya.
        ''',
          'image': imageName,
          'sections': [], // Kosongkan sections, akan diisi dari API
        });

        // Tambahkan log untuk debugging
        print(
            'Minggu ke-$weekNumber bulan ${_getIndonesianMonth(startDate.month)}: $startDate - $endDate');
      }
    }

    wartaItems.value = items;
  }

  void scrollToCurrentWeek() {
    DateTime now = DateTime.now();

    // Periksa apakah hari ini adalah hari Minggu
    bool isSunday = now.weekday == DateTime.sunday;

    // Jika hari ini adalah Minggu, cari minggu depan
    DateTime targetDate = isSunday ? now.add(Duration(days: 1)) : now;

    // Cari indeks minggu yang mengandung tanggal target
    int targetWeekIndex = wartaItems.indexWhere((item) {
      DateTime startDate = item['startDate'];
      DateTime endDate = item['endDate'];

      // Periksa apakah tanggal target berada dalam rentang minggu ini
      return targetDate.isAfter(startDate.subtract(Duration(days: 1))) &&
          targetDate.isBefore(endDate.add(Duration(days: 1)));
    });

    if (targetWeekIndex != -1) {
      currentPage.value = targetWeekIndex;
      print(
          'Minggu aktif: ${wartaItems[targetWeekIndex]['startDate']} - ${wartaItems[targetWeekIndex]['endDate']}');
      logInfo("${currentPage.value}");
      FirstIndex = currentPage.value;
    } else {
      // Jika minggu tidak ditemukan, cari minggu terdekat ke depan
      targetWeekIndex = wartaItems.indexWhere((item) {
        DateTime startDate = item['startDate'];
        return startDate.isAfter(targetDate);
      });

      if (targetWeekIndex != -1) {
        currentPage.value = targetWeekIndex;
        print(
            'Minggu aktif (terdekat ke depan): ${wartaItems[targetWeekIndex]['startDate']} - ${wartaItems[targetWeekIndex]['endDate']}');
        logInfo("${currentPage.value}");
        FirstIndex = currentPage.value;
      } else {
        // Jika tidak ada minggu ke depan, tampilkan minggu terakhir yang tersedia
        currentPage.value = wartaItems.length - 1;
        print(
            'Mi nggu aktif (terakhir): ${wartaItems[currentPage.value]['startDate']} - ${wartaItems[currentPage.value]['endDate']}');
        logInfo("${currentPage.value}");
        FirstIndex = currentPage.value;
      }
    }
  }

  Future<void> fetchAllJadwal(int index) async {
    try {
      isLoading.value = true; // Mulai loading
      final item = wartaItems[index];
      DateTime startDate = item['startDate'];
      DateTime endDate = item['endDate'];

      String formattedStartDate = _formatDate(startDate);
      String formattedEndDate = _formatDate(endDate);

      final url =
          "${ApiAuth.JADWAL_IBADAH}?start_date=${formattedStartDate}&end_date=${formattedEndDate}";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          print("Fetched data: ${data['data']}");

          // Ensure the data is a Map<String, dynamic>
          if (data['data'] is Map<String, dynamic>) {
            // Store the grouped schedules
            jadwalIbadah.value = data['data'];
            print("Jadwal successfully stored.");
          } else if (data['data'] is List) {
            // Handle case where data['data'] is a List instead of a Map
            print("Data is a List, converting to Map...");
            Map<String, dynamic> convertedData = {};
            for (var item in data['data']) {
              if (item is Map && item.containsKey('kategori')) {
                String kategori = item['kategori'];
                if (!convertedData.containsKey(kategori)) {
                  convertedData[kategori] = [];
                }
                convertedData[kategori].add(item);
              }
            }
            jadwalIbadah.value = convertedData;
            print("Data successfully converted and stored.");
          } else {
            print("Unexpected data format: ${data['data']}");
          }
          logInfo(jsonEncode(data['sections']));
          // Replace sections in wartaItems with data from API
          // Update sections from API
          if (data['sections'] is List) {
            List<dynamic> sections = data['sections'];
            wartaItems[index]['sections'] = sections.map((section) {
              return {
                'title': section['gmbr_section'],
                'content': section['url_gambar'],
              };
            }).toList();
            wartaItems.refresh(); // Trigger UI update
            logInfo(
                "Sections updated for week ${index + 1}: ${jsonEncode(sections)}");
          } else {
            wartaItems[index]['sections'] = [];
            wartaItems.refresh();
            logInfo(
                "No sections data found in API response for week ${index + 1}");
          }
        }
      } else {
        print("Failed to fetch jadwal: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching jadwal: $e");
      wartaItems[index]['sections'] = [];
      wartaItems.refresh();
    } finally {
      isLoading.value = false; // Selesai loading
    }
  }

  List<dynamic> getJadwalByKategori(String kategori) {
    return jadwalIbadah[kategori] ?? [];
  }

  void onPageChanged(int index) {
    currentPage.value = index;
    fetchAllJadwal(index);
  }

  String getMonthWeekText(int index) {
    try {
      final item = wartaItems[index];
      DateTime startDate = item['startDate'];
      DateTime endDate = item['endDate'];

      // Tentukan bulan yang relevan untuk minggu ini
      int relevantMonth = endDate.month; // Gunakan bulan dari endDate
      int weekNumberInMonth = 1;

      // Hitung ulang nomor minggu berdasarkan hari Minggu dalam bulan
      DateTime firstDayOfMonth = DateTime(endDate.year, relevantMonth, 1);
      DateTime currentSunday = firstDayOfMonth;

      // Cari hari Minggu pertama dalam bulan
      while (currentSunday.weekday != DateTime.sunday) {
        currentSunday = currentSunday.add(Duration(days: 1));
      }

      // Iterasi setiap hari Minggu dalam bulan
      while (currentSunday.isBefore(endDate)) {
        weekNumberInMonth++;
        currentSunday = currentSunday.add(Duration(days: 7));
      }

      String monthName = _getIndonesianMonth(relevantMonth);

      // Tambahkan print untuk debugging
      print(
          'Index: $index, Bulan: $monthName, Minggu ke-$weekNumberInMonth, Periode: ${_formatDate(startDate)} - ${_formatDate(endDate)}');

      return 'Bulan $monthName Minggu ke-$weekNumberInMonth';
    } catch (e) {
      print('Error in getMonthWeekText: $e');
      return '';
    }
  }

  int _getMaxWeeksInMonth(int month, int year) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    int weekCount = 0;
    DateTime current = firstDayOfMonth;

    // Iterasi setiap hari dalam bulan untuk menghitung jumlah hari Minggu
    while (current.isBefore(lastDayOfMonth.add(Duration(days: 1)))) {
      if (current.weekday == DateTime.sunday) {
        weekCount++;
      }
      current = current.add(Duration(days: 1));
    }

    return weekCount;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getIndonesianMonth(int month) {
    List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }

  // Helper method to get week range text
  String getWeekRangeText(List<DateTime> week) {
    return '${_formatDate(week.first)} - ${_formatDate(week.last)}';
  }

  String getWeekPeriod(int index) {
    try {
      final item = wartaItems[index];
      DateTime startDate = item['startDate'];
      DateTime endDate = item['endDate'];
      return '${_formatDate(startDate)} - ${_formatDate(endDate)}';
    } catch (e) {
      return '';
    }
  }

  Future<void> pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      withData: false,
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      logInfo(files.map((file) => file.path).toList().join(', '));
      selectedImages.clear();
      selectedImages.addAll(files);
    }
  }

  Future<void> uploadImages() async {
    EasyLoading.show();
    if (selectedImages.isEmpty) {
      Snackbar_top(
          title: "Maaf",
          message: "Silakan pilih gambar terlebih dahulu",
          kategori: "error",
          duration: 2);

      return;
    } else if (tglIbadahController.text.isEmpty) {
      Snackbar_top(
          title: "Maaf",
          message: "Pilih Tanggal Ibadah Minggu terlebih dahulu",
          kategori: "error",
          duration: 2);
      return;
    }

    try {
      var uri = Uri.parse("${ApiAuth.BASE_API_ONLINE}warta_section/store");
      var request = http.MultipartRequest("POST", uri);
      // Tambahkan input tanggal
      request.fields['tgl_ibadah'] = tglIbadahController.text;
      request.fields['base_url_app'] = BASE_URL_APP;

      for (var image in selectedImages) {
        request.files.add(
          await http.MultipartFile.fromPath("images[]", image.path),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString(); // Baca response

      if (response.statusCode == 200) {
        Snackbar_top(
            title: "Sukses",
            message: "Gambar berhasil diupload.",
            kategori: "success",
            duration: 2);

        fetchAllJadwal(currentPage.value); // Refresh fetchAllJadwal
        tglIbadahController.clear();
        selectedImages.clear();
        EasyLoading.dismiss();
      } else {
        logInfo("${responseBody}");
        Snackbar_top(
            title: "Maaf",
            message:
                "Gagal mengupload gambar: ${response.statusCode} \n$responseBody",
            kategori: "error",
            duration: 2);
        EasyLoading.dismiss();
      }
    } catch (e) {
      Snackbar_top(
          title: "Maaf",
          message: "Terjadi kesalahan: $e",
          kategori: "error",
          duration: 2);
      EasyLoading.dismiss();
    }
  }

  Future<void> deleteImagesWarta() async {
    EasyLoading.show();
    final item = wartaItems[currentPage.value];
    DateTime startDate = item['startDate'];
    DateTime endDate = item['endDate'];

    String formattedStartDate = _formatDate(startDate);
    String formattedEndDate = _formatDate(endDate);

    var response = await http.get(Uri.parse(
        "${ApiAuth.BASE_API_ONLINE}warta_section/delete?start_date=${formattedStartDate}&end_date=${formattedEndDate}"));
    var res = await jsonDecode(response.body);

    if (res['success']) {
      EasyLoading.dismiss();
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: "Semua Gambar Warta berhasil dihapus diMinggu ini.",

          /// Menghapus image dari list image yang akan di upload.
          kategori: "success",
          duration: 2);
      fetchAllJadwal(currentPage.value);
    } else {
      EasyLoading.dismiss();
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  String formatDate(DateTime date) {
    return '${date.day} ${_getIndonesianMonth(date.month)} ${date.year}';
  }

  void removeImage(File image) {
    selectedImages.remove(image);
  }

  @override
  void onClose() {
    controller.dispose(); // Hentikan AnimationController
    print("Warta_Controller onClose called");
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
