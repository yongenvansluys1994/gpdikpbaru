import 'package:get/get.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart';

import '../../common/api.dart';

class Jadwal_Controller_doa extends GetxController {
  final _dataJadwal_doa = <ModelJadwal>[].obs;
  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = true.obs;
  var duration = Duration(seconds: 1);

  Jadwal_Controller_doa();

  List<ModelJadwal> get dataJadwal_doa => _dataJadwal_doa.toList();

  ModelJadwal item_doa(int index) => _dataJadwal_doa[index];

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

  Future<void> loadGetJadwal_doa({required kategori}) async {
    final dataJadwal_doa = await ApiAuth.getJadwal(kategori: kategori);
    if (dataJadwal_doa == null) {
      print("null data doa");
      //data tidak ada
      _isFailed.value = true;
      _isLoading.value = false;
    } else {
      if (dataJadwal_doa.isEmpty) {
        print("isempty");
        //data kosong
        _isEmpty.value = true;
        _isLoading.value = false;
      } else {
        //berhasil load
        _dataJadwal_doa.addAll(dataJadwal_doa);
        _isEmpty.value = false;

        _isLoading.value = false;
      }
      _isFailed.value = false;
      _isLoading.value = false;
    }
  }

  Future<void> refreshdata() async {
    _dataJadwal_doa.clear();
    _isLoading.value = true;
    loadGetJadwal_doa(kategori: "doa_persekutuan");
  }
}
