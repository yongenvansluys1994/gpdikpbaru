import 'package:get/get.dart';
import 'package:gpdikpbaru/view/admin/alert_beranda/alert_beranda.dart';
import 'package:gpdikpbaru/view/admin/berita/berita.dart';
import 'package:gpdikpbaru/view/admin/broadcast/broadcast.dart';
import 'package:gpdikpbaru/view/admin/contactperson/contactperson_harian.dart';
import 'package:gpdikpbaru/view/admin/daftar_bank/daftar_bank.dart';
import 'package:gpdikpbaru/view/admin/jadwal/jadwal_ibadah.dart';
import 'package:gpdikpbaru/view/admin/jadwal/jadwal_input.dart';
import 'package:gpdikpbaru/view/admin/kolekte/kolekte.dart';
import 'package:gpdikpbaru/view/admin/live/live_harian.dart';
import 'package:gpdikpbaru/view/admin/radio/radio_admin.dart';

import 'package:gpdikpbaru/view/admin/renungan/renungan_harian.dart';
import 'package:gpdikpbaru/view/user/contactperson/contactperson_harian.dart';
import 'package:gpdikpbaru/view/user/games/games.dart';
import 'package:gpdikpbaru/view/user/games/games_detail.dart';
import 'package:gpdikpbaru/view/user/materi/materi.dart';
import 'package:gpdikpbaru/view/user/profil/editprofil.dart';
import 'package:gpdikpbaru/view/user/profil/myprofil.dart';
import 'package:gpdikpbaru/view/user/alkitab/alkitabonline.dart';
import 'package:gpdikpbaru/view/user/jadwal/jadwal.dart';
import 'package:gpdikpbaru/view/user/live/live_harian.dart';
import 'package:gpdikpbaru/view/user/livechat/livechat.dart';
import 'package:gpdikpbaru/view/user/persembahan/persembahan.dart';

import 'package:gpdikpbaru/view/auth/login_screen.dart';
import 'package:gpdikpbaru/view/auth/register_screen.dart';
import 'package:gpdikpbaru/view/user/profil/perjalanan_iman.dart';
import 'package:gpdikpbaru/view/user/profil/profil_user.dart';
import 'package:gpdikpbaru/view/user/radio/radio.dart';
import 'package:gpdikpbaru/view/user/renungan/renungan_harian.dart';
import 'package:gpdikpbaru/view/user/testing-page/testingpage.dart';
import 'package:gpdikpbaru/view/user/warta/warta.dart';

import '../bindings/home_bindings.dart';
import '../view/user/home.dart';

class GetRoutes {
  static const String home = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String profil = "/profil";

  static const String jadwal = "/jadwal";
  static const String jadwaldetail = "/jadwaldetail";
  static const String persembahan = "/persembahan";
  static const String persembahandetail = "/persembahandetail";
  static const String warta_jemaat = "/wartajemaat";
  static const String jadwalibadah = "/jadwalibadah";
  static const String jadwalinput = "/jadwalinput";
  static const String jadwaledit = "/jadwaledit";
  static const String renunganharian = "/renunganharian";
  static const String renunganpage = "/renunganpage";
  static const String renungandetail = "/renungandetail";
  static const String contactperson = "/contactperson";
  static const String contactpersonpage = "/contactpersonpage";
  static const String contactpersondetail = "/contactpersondetail";
  static const String live = "/live";
  static const String livepage = "/livepage";
  static const String livedetail = "/livedetail";
  static const String alkitab = "/alkitab";
  static const String livechat = "/livechat";
  static const String myprofil = "/myprofil";
  static const String editprofil = "/editprofil";
  static const String perjalanan_iman = "/perjalanan_iman";
  static const String radio = "/radio";
  static const String radioadmin = "/radioadmin";
  static const String games = "/games";
  static const String gamesadmin = "/gamesadmin";
  static const String materi = "/materi";
  static const String materiadmin = "/materiadmin";

  static const String berita = "/berita";
  static const String beritadetail = "/beritadetail";
  static const String kolekte = "/kolekte";
  static const String gamedetail = "/gamedetail";
  static const String kolektedetail = "/kolektedetail";
  static const String broadcast = "/broadcast";
  static const String daftarbank = "/daftarbank";
  static const String daftar_contactperson = "/daftar_contactperson";
  static const String contact_person = "/contact_person";
  static const String alert_beranda = "/alert_beranda";
  static const String profil_user = "/profil_user";
  static const String testing_page = "/testing_page";

  static List<GetPage> routes = [
    GetPage(name: home, page: () => Home(Get.find()), binding: Home2Bindings()),
    GetPage(name: jadwalibadah, page: () => jadwalIbadahAdmin()),
    GetPage(
        name: jadwalinput,
        page: () => jadwalInputAdmin(),
        binding: inputjadwalBindings()),
    GetPage(
        name: renunganharian,
        page: () => renunganAdmin(),
        binding: inputrenunganBindings()),
    GetPage(
        name: renunganpage,
        page: () => renunganPage(),
        binding: renunganBindings()),
    GetPage(name: live, page: () => liveAdmin(), binding: inputliveBindings()),
    GetPage(name: livepage, page: () => livePage(), binding: liveBindings()),
    GetPage(
        name: berita,
        page: () => beritaAdmin(),
        binding: inputberitaBindings()),
    GetPage(name: warta_jemaat, page: () => Warta(), binding: wartaBindings()),
    GetPage(
        name: kolekte,
        page: () => kolekteAdmin(),
        binding: KolekteAdminBindings()),
    GetPage(name: gamedetail, page: () => GamesDetail()),
    GetPage(name: kolektedetail, page: () => Get.arguments),
    GetPage(name: broadcast, page: () => broadcastAdmin()),
    GetPage(
        name: daftarbank,
        page: () => daftarBankAdmin(),
        binding: daftarBankBindings()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: renungandetail, page: () => Get.arguments),
    GetPage(name: livedetail, page: () => Get.arguments),
    GetPage(name: beritadetail, page: () => Get.arguments),
    GetPage(name: jadwaldetail, page: () => Get.arguments),
    GetPage(name: jadwaledit, page: () => Get.arguments),
    GetPage(
        name: persembahan,
        page: () => Persembahan(),
        binding: PersembahanBindings()),
    GetPage(name: persembahandetail, page: () => Get.arguments),
    GetPage(name: alkitab, page: () => alkitabPage()),
    GetPage(name: livechat, page: () => livechatPage()),
    GetPage(name: myprofil, page: () => MyProfil()),
    GetPage(
        name: editprofil,
        page: () => editProfil(),
        binding: editprofilBindings()),
    GetPage(
        name: perjalanan_iman,
        page: () => perjalananIman(),
        binding: perjalananImanBindings()),
    GetPage(name: radio, page: () => RadioLive(), binding: radioBindings()),
    GetPage(
        name: radioadmin,
        page: () => radioAdmin(),
        binding: radioadminBindings()),
    GetPage(name: games, page: () => GamesPage(), binding: gamesBindings()),
    GetPage(name: materi, page: () => Materi(), binding: materiBindings()),
    GetPage(
        name: contactperson,
        page: () => contactpersonAdmin(),
        binding: inputcontactpersonBindings()),
    GetPage(
        name: contact_person,
        page: () => contactpersonUser(),
        binding: daftarCPBindings()),
    GetPage(
        name: alert_beranda,
        page: () => alertBeranda(),
        binding: alertBerandaBindings()),
    GetPage(
        name: profil_user,
        page: () => ProfilUser(),
        binding: ProfilUserPageBindings()),
    GetPage(
        name: testing_page,
        page: () => TestingPage(),
        binding: testingPageBindings()),
  ];
}
