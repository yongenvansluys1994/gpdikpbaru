import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:gpdikpbaru/controller/home_controller2.dart';

import 'package:gpdikpbaru/widgets/getdialog.dart';
import 'package:gpdikpbaru/widgets/loader3.dart';

class p_iman_controller extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

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
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  List<Map<String, String>> getBadges() {
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

      if (p_task1 > 1)
        badges.add({
          'task': 'p_task1',
          'badge': 'assets/badge/1.png',
          'name': nm_task1
        });
      if (p_task2 > 1)
        badges.add({
          'task': 'p_task2',
          'badge': 'assets/badge/2.png',
          'name': nm_task2
        });
      if (p_task3 > 1)
        badges.add({
          'task': 'p_task3',
          'badge': 'assets/badge/3.png',
          'name': nm_task3
        });
      if (p_task4 > 1)
        badges.add({
          'task': 'p_task4',
          'badge': 'assets/badge/4.png',
          'name': nm_task4
        });
      if (p_task5 > 1)
        badges.add({
          'task': 'p_task5',
          'badge': 'assets/badge/5.png',
          'name': nm_task5
        });
      if (p_task6 > 1)
        badges.add({
          'task': 'p_task6',
          'badge': 'assets/badge/6.png',
          'name': nm_task6
        });
      if (p_task7 > 1)
        badges.add({
          'task': 'p_task7',
          'badge': 'assets/badge/7.png',
          'name': nm_task7
        });
      if (p_task8 > 1)
        badges.add({
          'task': 'p_task8',
          'badge': 'assets/badge/8.png',
          'name': nm_task8
        });
      if (p_task9 > 1)
        badges.add({
          'task': 'p_task9',
          'badge': 'assets/badge/9.png',
          'name': nm_task9
        });
      if (p_task10 > 1)
        badges.add({
          'task': 'p_task10',
          'badge': 'assets/badge/10.png',
          'name': nm_task10
        });
      if (p_task11 > 1)
        badges.add({
          'task': 'p_task11',
          'badge': 'assets/badge/11.png',
          'name': nm_task11
        });
    }

    return badges;
  }

  Future<void> proses_p_iman() async {
    final ReloadData = Get.find<home_controller2>();

    collectionReference = firebaseFirestore
        .collection("data_user")
        .doc(ReloadData.items[0].username)
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
      }
    });
  }

  edit_lencana(
      {required String id_user,
      required String username,
      required String lencana}) async {
    GetLoader();

    //update data pembayaran di firebase dan mengubah status menjadi 1
    FirebaseFirestore.instance
        .collection('data_user')
        .doc('${username}')
        .update({'lencana': lencana}).whenComplete(
      () async {
        //update semua image & lencana chat comments
        WriteBatch batch = FirebaseFirestore.instance.batch();
        FirebaseFirestore.instance
            .collection("livechat")
            .where("no_hp", whereIn: ['${username}'])
            .get()
            .then((querySnapshot) {
              querySnapshot.docs.forEach((document) {
                batch.update(document.reference, {"lencana": lencana});
              });
              return batch.commit();
            });
        WriteBatch batch2 = FirebaseFirestore.instance.batch();
        FirebaseFirestore.instance
            .collection("comments")
            .where("id_user", whereIn: ['${id_user}'])
            .get()
            .then((querySnapshot) {
              querySnapshot.docs.forEach((document) {
                batch2.update(document.reference, {"lencana": lencana});
              });
              return batch2.commit();
            });
        Get.back();
        getDefaultDialogtoHome("Lencana Berhasil Dipakai", "success", 2);
      },
    );
    //end edit data firebase data_user
  }

  Stream<List> getAllData() => collectionReference
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((query) => query.docs.map((item) => (item)).toList());

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void hapusisi() {}
}
