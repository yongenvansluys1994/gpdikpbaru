import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/admin/alert_beranda_controller.dart';
import 'package:gpdikpbaru/controller/admin/bank_controller.dart';
import 'package:gpdikpbaru/controller/admin/broadcast_controller.dart';
import 'package:gpdikpbaru/controller/admin/data_contactperson_controller.dart';
import 'package:gpdikpbaru/controller/admin/data_live_controller.dart';
import 'package:gpdikpbaru/controller/admin/data_renungan_controller.dart';
import 'package:gpdikpbaru/controller/admin/inputcontactperson_controller.dart';
import 'package:gpdikpbaru/controller/admin/inputberita_controller.dart';
import 'package:gpdikpbaru/controller/admin/inputjadwal_controller.dart';
import 'package:gpdikpbaru/controller/admin/inputlive_controller.dart';
import 'package:gpdikpbaru/controller/admin/inputrenungan_controller.dart';
import 'package:gpdikpbaru/controller/admin/kolekte_controller.dart';
import 'package:gpdikpbaru/controller/admin/radio_admin_controller.dart';
import 'package:gpdikpbaru/controller/games/games_controller.dart';
import 'package:gpdikpbaru/controller/home_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller_doa.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller_pelprap.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller_pelprip.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller_pelwap.dart';
import 'package:gpdikpbaru/controller/materi/inputmateri_controller.dart';
import 'package:gpdikpbaru/controller/materi/materi_controller.dart';
import 'package:gpdikpbaru/controller/persembahan/persembahan_controller.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';
import 'package:gpdikpbaru/controller/profil/editprofil_controller.dart';
import 'package:gpdikpbaru/controller/profil/p_iman_controller.dart';
import 'package:gpdikpbaru/controller/profil/profiluser_controller.dart';

import 'package:gpdikpbaru/controller/radio/radio_controller.dart';
import 'package:gpdikpbaru/controller/testingpage_controller.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/controller/warta/comments_warta_controller.dart';
import 'package:gpdikpbaru/controller/warta/warta_controller.dart';

class Home2Bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => themedark());
    Get.lazyPut(() => home_controller2());
    Get.lazyPut(() => home_controller());
    Get.put(poiniman_controller());
    Get.lazyPut(() => p_iman_controller());
  }
}

class PersembahanBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Persembahan_Controller());
  }
}

class KolekteAdminBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Kolekte_Controller());
  }
}

class daftarBankBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Bank_Controller());
  }
}

class daftarCPBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactPerson_Controller());
  }
}

class alertBerandaBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => alertBeranda_Controller());
  }
}

class testingPageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TestingPageController());
  }
}

class ProfilUserPageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilUserPageController());
  }
}

class inputjadwalBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => inputJadwalController());
  }
}

class inputrenunganBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => inputRenunganController());
    Get.lazyPut(() => Renungan_Controller());
  }
}

class inputcontactpersonBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => inputContactPersonController());
    Get.lazyPut(() => ContactPerson_Controller());
  }
}

class inputliveBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => inputLiveController());
    Get.lazyPut(() => Live_Controller());
  }
}

class editprofilBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => editprofil_controller());
  }
}

class perjalananImanBindings implements Bindings {
  @override
  void dependencies() {}
}

class renunganBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Renungan_Controller());
  }
}

class liveBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Live_Controller());
  }
}

class inputberitaBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => inputBeritaController());
  }
}

class broadcastBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => broadcast_Controller());
  }
}

class radioBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Radio_Controller());
  }
}

class radioadminBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => radioAdmin_Controller());
  }
}

class gamesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Games_Controller());
  }
}

class materiBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Materi_Controller());
    Get.lazyPut(() => inputMateriController());
  }
}

class wartaBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Warta_Controller());
    Get.lazyPut(() => Jadwal_Controller());
    Get.lazyPut(() => CommentsWartaController());
  }
}
