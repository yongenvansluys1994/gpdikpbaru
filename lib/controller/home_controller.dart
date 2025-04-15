import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/models/model_databerita.dart';
import 'package:gpdikpbaru/models/model_datarenungan.dart';

import '../common/api.dart';

class home_controller extends GetxController {
  final _datalist = <ModeldataRenungan>[].obs;
  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = true.obs;
  var duration = Duration(seconds: 1);

  home_controller();

  List<ModeldataRenungan> get datalist => _datalist.toList();

  ModeldataRenungan item(int index) => _datalist[index];

  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;

  ScrollController scrollController = ScrollController();
  final _visible = true.obs;
  bool get visible => _visible.value;

  @override
  void onInit() {
    controllerscroll();
    init();

    super.onInit();
  }

  Future<void> controllerscroll() async {
    ScrollDirection? _lastScrollDirection;
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (_lastScrollDirection !=
          scrollController.position.userScrollDirection) {
        _lastScrollDirection = scrollController.position.userScrollDirection;
        visible ? _visible.value = false : _visible.value = true;
        print('Scroll direction changed --> $_lastScrollDirection');
      }
    });
  }

  Future<void> init() async {
    final datalist = await ApiAuth.datarenunganall();
    if (datalist == null) {
      print("null data jadwal");
      //data tidak ada
      _isFailed.value = true;
      _isLoading.value = false;
    } else {
      if (datalist.isEmpty) {
        print("isempty");
        //data kosong
        _isEmpty.value = true;
        _isLoading.value = false;
      } else {
        //berhasil load
        _datalist.addAll(datalist);
        _isEmpty.value = false;
        _isLoading.value = false;
      }
      _isFailed.value = false;
    }
  }

  Future<void> refreshdata() async {
    _datalist.clear();
    _isLoading.value = true;
    init();
  }
}
