import 'dart:convert';

import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';

import 'package:http/http.dart' as http;

class Games_Controller extends GetxController {
  var gameList = <dynamic>[].obs; // List reaktif untuk menyimpan data game
  var isLoading = false.obs; // Indikator loading

  @override
  void onInit() {
    super.onInit();
    fetchGames(); // Panggil fetchGames saat controller diinisialisasi
  }

  Future<void> fetchGames() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      final url = "${ApiAuth.BASE_API_ONLINE}datagame";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final newData = data['data'] as List;
          gameList.assignAll(newData); // Tambahkan semua data ke gameList
        } else {
          print("Failed to fetch data: ${data['message']}");
        }
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
