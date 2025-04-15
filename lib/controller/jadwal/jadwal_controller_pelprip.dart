import 'package:get/get.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart';

import '../../common/api.dart';

class Jadwal_Controller_pelprip extends GetxController {
  final _dataJadwal = <ModelJadwal>[].obs;
  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = true.obs;
  var duration = Duration(seconds: 1);

  Jadwal_Controller_pelprip();

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
      print("null data pelprip");
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
      _isLoading.value = false;
    }
  }

  Future<void> refreshdata() async {
    _dataJadwal.clear();
    _isLoading.value = true;
    loadGetJadwal(kategori: "ibadah_pelprip");
  }
}
