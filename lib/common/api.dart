import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:gpdikpbaru/common/shared_prefs.dart';
import 'package:gpdikpbaru/models/model_contactperson.dart';
import 'package:gpdikpbaru/models/model_databerita.dart';
import 'package:gpdikpbaru/models/model_datagame.dart';
import 'package:gpdikpbaru/models/model_datalive.dart';
import 'package:gpdikpbaru/models/model_datarenungan.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart';
import 'package:gpdikpbaru/models/model_profil.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class Api {
  static const String BASE_URL = 'https://gorest.co.in/public/v1/';
  static const String USER = BASE_URL + 'users';

  static Future<List<User>?> users(int page) async {
    final url = '$USER?page=$page';
    final res = await http.get(Uri.parse(url));

    print(url);

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);

      if (json is Map && json.containsKey('data')) {
        final data = json['data']['data'];

        if (data is List) {
          return data.map<User>((u) => User.fromJson(u)).toList();
        }
      }
    }

    return null;
  }
}

class JamIbadah {
  static int IbadahMinggu_hari = 7; //hari (angka urut) (7)
  static int IbadahMinggu_start = 9; //jam mulai (24)
  static int IbadahMinggu_end = 11; //jam selesai (24)
  static int IbadahPelprap_hari = 6; //hari (angka urut) (7)
  static int IbadahPelprap_start = 19; //jam mulai (24)
  static int IbadahPelprap_end = 21; //jam selesai (24)
}

class ApiAuth {
  static String ApiFCM =
      "AAAAx9qNei4:APA91bEkZYmk2JhKtPjMEIjaLBKUoqBSRqHLaoVZrmmUyAPgdpkEXkXxAYjuBeckgtZcOf9O-PF0-_48E_kh0fvNqgvOvCizWmkEUr28k1FsJQb7NIPVz-A2DkwGpXrd_Hbs4viRZSUN";
  //untuk mendapatkan Token FCM buka di firebase>Project Settings>Cloud Message>Cloud Messaging(Legacy)
  static String dbRealtime = 'https://gpdiphiladelphia.firebaseio.com/';
  static String APP_NAME = 'GPdI Filadelfia Kp.Baru';
  static int APP_VERSION =
      10; //jangan lupa untuk mengubah versi app yang sama dengan ini di android/app/build.gradle line 61 & 62
  static String projectId = "gpdiphiladelphia"; //ambil dari firebase
  static String BASE_URL_APP = 'https://yongen-bisa.com/backend_gpdi/';
  //static String BASE_URL_APP = "http://10.0.2.2/backend_gpdi/public/";

  static String BASE_API_ONLINE = 'https://yongen-bisa.com/backend_gpdi/api/';
  // static String BASE_API_ONLINE = 'http://10.0.2.2:8000/api/';
  static String REGISTER = BASE_API_ONLINE + 'auth/register';
  static String LOGIN = BASE_API_ONLINE + 'auth/login';
  static String USER = BASE_API_ONLINE + 'auth';
  static String JADWAL_IBADAH = BASE_API_ONLINE + 'jadwal/all';
  static String INPUT_JADWAL = BASE_API_ONLINE + 'jadwal_ibadah/store';
  static String EDIT_JADWAL = BASE_API_ONLINE + 'jadwal_ibadah/edit';
  static String HAPUS_JADWAL = BASE_API_ONLINE + 'jadwal_ibadah/delete';
  static String INPUT_SECTION = BASE_API_ONLINE + 'warta_section/store';
  static String DATA_RENUNGAN = BASE_API_ONLINE + 'renungan';
  static String DATA_RENUNGAN_ALL = BASE_API_ONLINE + 'renungan';
  static String DATA_PENGUMUMAN = BASE_API_ONLINE + 'pengumuman';
  static String DATA_PENGUMUMAN_ALL = BASE_API_ONLINE + 'renungan_all';
  static String INPUT_RENUNGAN = BASE_API_ONLINE + 'renungan/store';
  static String INPUT_PENGUMUMAN =
      BASE_API_ONLINE + 'renungan/store_pengumuman';
  static String EDIT_RENUNGAN = BASE_API_ONLINE + 'renungan/edit';
  static String HAPUS_RENUNGAN = BASE_API_ONLINE + 'renungan/delete';
  static String DATA_LIVE = BASE_API_ONLINE + 'live';
  static String INPUT_LIVE = BASE_API_ONLINE + 'live/store';
  static String EDIT_LIVE = BASE_API_ONLINE + 'live/edit';
  static String HAPUS_LIVE = BASE_API_ONLINE + 'live/hapus';
  static String DATA_BERITA = BASE_API_ONLINE + 'kegiatan';
  static String DATA_BERITA_ALL = BASE_API_ONLINE + 'kegiatan';
  static String INPUT_BERITA = BASE_API_ONLINE + 'kegiatan/store';
  static String EDIT_BERITA = BASE_API_ONLINE + 'kegiatan/edit';
  static String HAPUS_BERITA = BASE_API_ONLINE + 'kegiatan/delete';
  static String DATA_CONTACTPERSON = BASE_API_ONLINE + 'contactperson';
  static String INPUT_CONTACTPERSON = BASE_API_ONLINE + 'contactperson/store';
  static String EDIT_CONTACTPERSON = BASE_API_ONLINE + 'contactperson/edit';
  static String HAPUS_CONTACTPERSON = BASE_API_ONLINE + 'contactperson/delete';
  static String DATA_GAME = BASE_API_ONLINE + 'datagame';
  static String INPUT_GAME = BASE_API_ONLINE + 'datagame/store';
  static String EDIT_GAME = BASE_API_ONLINE + 'datagame/edit';
  static String HAPUS_GAME = BASE_API_ONLINE + 'datagame/delete';
  static String EDIT_PROFIL = BASE_API_ONLINE + 'auth/edit';
  static String CEK_UTILITAS = BASE_API_ONLINE + 'utilitas/1';
  static String EVENT_FIRSTLOGIN = BASE_API_ONLINE + 'eventfirstlogin';

  static Future<List<User>?> users(int page) async {
    final url = '$REGISTER?page=$page';
    final res = await http.get(Uri.parse(url));

    print(url);

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);

      if (json is Map && json.containsKey('data')) {
        final data = json['data'];

        if (data is List) {
          return data.map<User>((u) => User.fromJson(u)).toList();
        }
      }
    }

    return null;
  }

  static Future<List<ModeldataRenungan>?> datarenungan(int page) async {
    final url = '$DATA_RENUNGAN?page=$page';
    final res = await http.get(Uri.parse(url));

    print(url);

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);
      if (json is Map && json.containsKey('data')) {
        final data = json['data']['data'];
        if (data is List) {
          return data
              .map<ModeldataRenungan>((u) => ModeldataRenungan.fromJson(u))
              .toList();
        }
      }
    }

    return null;
  }

  static Future<List<ModeldataRenungan>?> datapengumuman(int page) async {
    final url = '$DATA_PENGUMUMAN?page=$page';
    final res = await http.get(Uri.parse(url));

    print(url);

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);
      if (json is Map && json.containsKey('data')) {
        final data = json['data']['data'];
        if (data is List) {
          return data
              .map<ModeldataRenungan>((u) => ModeldataRenungan.fromJson(u))
              .toList();
        }
      }
    }

    return null;
  }

  static Future<List<ModelContactPerson>?> datacontactperson(int page) async {
    final url = '$DATA_CONTACTPERSON?page=$page';
    final res = await http.get(Uri.parse(url));

    print(url);
    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);
      if (json is Map && json.containsKey('data')) {
        final data = json['data']['data'];
        if (data is List) {
          return data
              .map<ModelContactPerson>((u) => ModelContactPerson.fromJson(u))
              .toList();
        }
      }
    }

    return null;
  }

  static Future<List<ModelDataGame>?> datagame(int page) async {
    final url = '$DATA_GAME?page=$page';
    final res = await http.get(Uri.parse(url));

    print(url);
    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);
      if (json is Map && json.containsKey('data')) {
        final data = json['data']['data'];
        if (data is List) {
          return data
              .map<ModelDataGame>((u) => ModelDataGame.fromJson(u))
              .toList();
        }
      }
    }

    return null;
  }

  static Future<List<ModeldataRenungan>?> datarenunganall() async {
    final url = '$DATA_PENGUMUMAN_ALL';
    final res = await http.get(Uri.parse(url));

    print(url);

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);

      if (json is Map && json.containsKey('data')) {
        final data = json['data']['data'];

        if (data is List) {
          return data
              .map<ModeldataRenungan>((u) => ModeldataRenungan.fromJson(u))
              .toList();
        }
      }
    }

    return null;
  }

  static Future<List<ModeldataBerita>?> databeritaall() async {
    final url = '$DATA_BERITA_ALL';
    final res = await http.get(Uri.parse(url));

    print(url);

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);

      if (json is Map && json.containsKey('data')) {
        final data = json['data']['data'];

        if (data is List) {
          return data
              .map<ModeldataBerita>((u) => ModeldataBerita.fromJson(u))
              .toList();
        }
      }
    }

    return null;
  }

  static Future<List<ModeldataBerita>?> databerita(int page) async {
    final url = '$DATA_BERITA?page=$page';
    final res = await http.get(Uri.parse(url));

    print(url);

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);

      if (json is Map && json.containsKey('data')) {
        final data = json['data']['data'];

        if (data is List) {
          return data
              .map<ModeldataBerita>((u) => ModeldataBerita.fromJson(u))
              .toList();
        }
      }
    }

    return null;
  }

  static Future<List<ModeldataLive>?> datalive(int page) async {
    final url = '$DATA_LIVE?page=$page';
    final res = await http.get(Uri.parse(url));

    print(url);

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);

      if (json is Map && json.containsKey('data')) {
        final data = json['data']['data'];

        if (data is List) {
          return data
              .map<ModeldataLive>((u) => ModeldataLive.fromJson(u))
              .toList();
        }
      }
    }

    return null;
  }

  static Future<List<ModelProfil>?> fetchdatauser() async {
    var jsonshared = await SharedPrefs().getUser();
    final datashared = [json.decode(jsonshared)];
    final id_user = datashared[0]['id_user'];
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return datashared
          .map<ModelProfil>((u) => ModelProfil.fromJson(u))
          .toList();
    } else {
      final url = '$USER/$id_user';
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final json = await compute(jsonDecode, res.body);
        if (json is Map && json.containsKey('data')) {
          final data = json['data'];
          if (data is List) {
            return data
                .map<ModelProfil>((u) => ModelProfil.fromJson(u))
                .toList();
          }
        }
      }
    }

    return null;
  }

  static Future<List<ModelJadwal>?> getJadwal(
      {required String kategori}) async {
    final url = '$JADWAL_IBADAH/$kategori';
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final json = await compute(jsonDecode, res.body);

      if (json is Map && json.containsKey('data')) {
        final data = json['data'];

        if (data is List) {
          return data.map<ModelJadwal>((u) => ModelJadwal.fromJson(u)).toList();
        }
      }
    }

    return null;
  }
}
