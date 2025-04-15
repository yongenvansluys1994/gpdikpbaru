import 'dart:convert';

import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller_doa.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller_pelprap.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller_pelprip.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller_pelwap.dart';
import 'package:gpdikpbaru/controller/warta/warta_controller.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';

import 'package:http/http.dart' as http;

import '../../common/api.dart';

class Jadwal_Controller extends GetxController {
  final _dataJadwal = <ModelJadwal>[].obs;

  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = true.obs;
  var duration = Duration(seconds: 1);

  Jadwal_Controller();

  List<ModelJadwal> get dataJadwal => _dataJadwal.toList();

  ModelJadwal item(int index) => _dataJadwal[index];

  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;

  // @override
  // void onInit() {
  //   _init();
  //   super.onInit();
  // }

  // Future<void> _init() async {
  //   await loadGetJadwal();
  // }

  Future<void> loadGetJadwal({required kategori}) async {
    final dataJadwal = await ApiAuth.getJadwal(kategori: kategori);
    if (dataJadwal == null) {
      print("null data jadwal");
      //data tidak ada
      _isFailed.value = true;
      _isLoading.value = false;
    } else {
      if (dataJadwal.isEmpty) {
        print("isempty");
        //data kosong
        _isEmpty.value = true;
        _isLoading.value = false;
      } else {
        //berhasil load
        _dataJadwal.addAll(dataJadwal);
        _isEmpty.value = false;
        _isLoading.value = false;
      }
      _isFailed.value = false;
    }
  }

  Future<void> refreshdata() async {
    _dataJadwal.clear();
    _isLoading.value = true;
    loadGetJadwal(kategori: "ibadah_minggu");
  }

  hapusjadwal({required id_jadwal}) async {
    var response =
        await http.get(Uri.parse("${ApiAuth.HAPUS_JADWAL}/${id_jadwal}"));
    var res = await jsonDecode(response.body);
    if (res['success']) {
      Get.back();
      Get.back();
      Snackbar_top(
          title: "Success",
          message: res['message'],
          kategori: "success",
          duration: 1);
      //refresh
      final ReloadData = Get.find<Warta_Controller>();
      int getCurrentPage = ReloadData.currentPage.value;
      await ReloadData.fetchAllJadwal(getCurrentPage);
      print("berhasil refresh");
    } else {
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }
}
