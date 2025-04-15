import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/models/model_profil.dart';
import 'package:gpdikpbaru/widgets/loader3.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';

import 'package:http/http.dart' as http;

class Materi_Controller extends GetxController {
  var materiList = <dynamic>[].obs; // List reaktif untuk menyimpan data materi
  var isLoading = false.obs; // Indikator loading
  var isLoadingMore = false.obs; // Indikator loading untuk pagination
  var hasReachedMax = false.obs; // Indikator apakah data sudah habis
  var currentPage = 1.obs; // Halaman saat ini
  var nextPageUrl = ''.obs; // URL untuk halaman berikutnya
  var dataProfil = <ModelProfil>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMateri(); // Panggil fetchMateri saat controller diinisialisasi
    // Ambil data dataProfil dari Get.arguments

    dataProfil.add(Get.arguments as ModelProfil);
  }

  Future<void> fetchMateri({bool isLoadMore = false}) async {
    if (isLoading.value || isLoadingMore.value || hasReachedMax.value) return;

    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }

      final url = isLoadMore && nextPageUrl.value.isNotEmpty
          ? nextPageUrl.value
          : "${ApiAuth.BASE_API_ONLINE}materi?page=${currentPage.value}";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final newData = data['data']['data'] as List;

          if (newData.isEmpty) {
            hasReachedMax.value = true; // Tandai bahwa data sudah habis
            logInfo("Data kosong");
          } else {
            if (!isLoadMore) {
              materiList.clear(); // Kosongkan list hanya jika bukan load more
            }
            materiList.addAll(newData); // Tambahkan data baru ke list
            currentPage.value =
                data['data']['current_page']; // Perbarui halaman saat ini
            nextPageUrl.value = data['data']['next_page_url'] ??
                ''; // Perbarui URL halaman berikutnya

            if (data['data']['next_page_url'] == null) {
              hasReachedMax.value =
                  true; // Tandai bahwa tidak ada halaman berikutnya
              logInfo("Tidak ada halaman berikutnya");
            }
          }
        } else {
          print("Failed to fetch data: ${data['message']}");
        }
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      if (isLoadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  void delete(String id_kegiatan) async {
    GetLoader(); // Tampilkan loader
    try {
      // Kirim permintaan delete ke server
      var response = await http.get(
          Uri.parse("${ApiAuth.BASE_API_ONLINE}materi/delete/${id_kegiatan}"));
      var res = jsonDecode(response.body);

      if (res['success']) {
        // Tutup loader
        Get.back();

        // Tampilkan snackbar sukses
        Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1,
        );

        // Hapus data secara lokal dari materiList
        materiList.removeWhere((item) => item['id'].toString() == id_kegiatan);

        // Refresh data dari server
        fetchMateri(); // Panggil fetchMateri untuk memuat ulang data
      } else {
        // Tutup loader
        Get.back();

        // Tampilkan snackbar error
        RawSnackbar_bottom(
          message: res['message'],
          kategori: "error",
          duration: 1,
        );
      }
    } catch (e) {
      // Tangani error
      print("Error deleting materi: $e");
      Get.back(); // Tutup loader jika terjadi error
      RawSnackbar_bottom(
        message: "Terjadi kesalahan saat menghapus materi",
        kategori: "error",
        duration: 1,
      );
    }
  }
}
