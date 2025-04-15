import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/common/push_notification/push_notif_topic.dart';
import 'package:gpdikpbaru/controller/warta/warta_controller.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gpdikpbaru/widgets/loader.dart';
import 'package:gpdikpbaru/widgets/loader3.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class inputJadwalController extends GetxController {
  final box = GetStorage();
  late TextEditingController tanggalCon,
      jamCon,
      lokasiCon,
      alamatCon,
      hambaTuhanCon,
      wlCon,
      singerCon,
      pmusikCon,
      pkolekteCon,
      ptamuCon;
  late TextEditingController jamTempCon,
      lokasiTempCon,
      alamatTempCon,
      hambaTuhanTempCon,
      wlTempCon,
      singerTempCon,
      pmusikTempCon,
      pkolekteTempCon,
      ptamuTempCon;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    tanggalCon = TextEditingController();
    jamCon = TextEditingController();
    lokasiCon = TextEditingController();
    alamatCon = TextEditingController();
    hambaTuhanCon = TextEditingController();
    wlCon = TextEditingController();
    singerCon = TextEditingController();
    pmusikCon = TextEditingController();
    pkolekteCon = TextEditingController();
    ptamuCon = TextEditingController();

    jamTempCon = TextEditingController();
    lokasiTempCon = TextEditingController();
    alamatTempCon = TextEditingController();
    hambaTuhanTempCon = TextEditingController();
    wlTempCon = TextEditingController();
    singerTempCon = TextEditingController();
    pmusikTempCon = TextEditingController();
    pkolekteTempCon = TextEditingController();
    ptamuTempCon = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    tanggalCon.dispose();
    jamCon.dispose();
    lokasiCon.dispose();
    alamatCon.dispose();
    hambaTuhanCon.dispose();
    wlCon.dispose();
    singerCon.dispose();
    pmusikCon.dispose();
    pkolekteCon.dispose();
    ptamuCon.dispose();
  }

  void hapusisicontroller() {
    jamCon.text = "";
    lokasiCon.text = "";
    alamatCon.text = "";
    hambaTuhanCon.text = "";
    wlCon.text = "";
    singerCon.text = "";
    pmusikCon.text = "";
    pkolekteCon.text = "";
    ptamuCon.text = "";
  }

  CheckInput(
      {required kategori,
      required String aksi,
      required String id_jadwal,
      required String title}) {
    GetLoader();
    if (tanggalCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Tanggal harus di isi", kategori: "error", duration: 1);
    } else if (jamCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Jam harus di isi", kategori: "error", duration: 1);
    } else if (lokasiCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Lokasi harus di isi", kategori: "error", duration: 1);
    } else if (alamatCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Alamat harus di isi", kategori: "error", duration: 1);
    } else if (hambaTuhanCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "Hamba Tuhan harus di isi", kategori: "error", duration: 1);
    } else if (wlCon.text.isEmpty) {
      RawSnackbar_bottom(
          message: "WL harus di isi", kategori: "error", duration: 1);
    } else if (kategori == "ibadah_minggu") {
      if (singerCon.text.isEmpty) {
        RawSnackbar_bottom(
            message: "Singer harus di isi", kategori: "error", duration: 1);
      } else if (pmusikCon.text.isEmpty) {
        RawSnackbar_bottom(
            message: "Pemain Musik harus di isi",
            kategori: "error",
            duration: 1);
      } else if (pkolekteCon.text.isEmpty) {
        RawSnackbar_bottom(
            message: "P. Kolekte harus di isi", kategori: "error", duration: 1);
      } else if (ptamuCon.text.isEmpty) {
        RawSnackbar_bottom(
            message: "P. Tamu harus di isi", kategori: "error", duration: 1);
      } else {
        if (aksi == "input") {
          Get.showOverlay(
              asyncFunction: () =>
                  inputjadwal(kategori: kategori, title: title),
              loadingWidget: Loader());
        } else if (aksi == "edit") {
          Get.showOverlay(
              asyncFunction: () =>
                  editjadwal(kategori: kategori, id_jadwal: id_jadwal),
              loadingWidget: Loader());
        }
      }
    } else {
      if (aksi == "input") {
        Get.showOverlay(
            asyncFunction: () => inputjadwal(kategori: kategori, title: title),
            loadingWidget: Loader());
      } else if (aksi == "edit") {
        Get.showOverlay(
            asyncFunction: () =>
                editjadwal(kategori: kategori, id_jadwal: id_jadwal),
            loadingWidget: Loader());
      }
    }
  }

  inputjadwal({required kategori, required String title}) async {
    var response = await http.post(Uri.parse(ApiAuth.INPUT_JADWAL), body: {
      "tanggal": tanggalCon.text,
      "kategori": kategori,
      "jam": jamCon.text,
      "lokasi": lokasiCon.text,
      "alamat": alamatCon.text,
      "hamba_tuhan": hambaTuhanCon.text,
      "wl": wlCon.text,
      "singer": singerCon.text,
      "pmusik": pmusikCon.text,
      "pkolekte": pkolekteCon.text,
      "ptamu": ptamuCon.text,
    });
    var res = await jsonDecode(response.body);
    Get.back();
    if (res['success']) {
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);
      // sendPushMessage_topic("user", "Info Jadwal ${title}",
      //     "Klik untuk melihat Informasi detail mengenai Jadwal ${title}");
      //refreshdata
      final ReloadData = Get.find<Warta_Controller>();
      int getCurrentPage = ReloadData.currentPage.value;
      await ReloadData.fetchAllJadwal(getCurrentPage);
      //endrefreshdata
    } else {
      Get.back();
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  editjadwal({required kategori, required String id_jadwal}) async {
    GetLoader();
    var response =
        await http.post(Uri.parse("${ApiAuth.EDIT_JADWAL}/$id_jadwal"), body: {
      "kategori": kategori,
      "tanggal": tanggalCon.text,
      "jam": jamCon.text,
      "lokasi": lokasiCon.text,
      "alamat": alamatCon.text,
      "hamba_tuhan": hambaTuhanCon.text,
      "wl": wlCon.text,
      "singer": singerCon.text,
      "pmusik": pmusikCon.text,
      "pkolekte": pkolekteCon.text,
      "ptamu": ptamuCon.text,
    });
    var res = await jsonDecode(response.body);
    if (res['success']) {
      Get.back();
      Get.back();
      Snackbar_top(
          title: "Sukses",
          message: res['message'],
          kategori: "success",
          duration: 1);
    } else {
      RawSnackbar_bottom(
          message: res['message'], kategori: "error", duration: 1);
    }
  }

  void changevaluetanggal({required formattedDate}) {
    tanggalCon.text = formattedDate;
  }

  Future<void> showDialogTemp(context, argument) async {
    loadTemp(argument);
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Data Template',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text("Jam Ibadah :"),
                      ),
                      Container(
                        child: TextFormField(
                          controller: jamTempCon,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(3, 3, 3, 0),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Jam Ibadah',
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: lightGreenColor, width: 0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Data harus diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 164, 186, 206),
                            blurRadius: 1,
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text("Lokasi Ibadah :"),
                      ),
                      Container(
                        child: TextFormField(
                          controller: lokasiTempCon,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(3, 3, 3, 0),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Lokasi Ibadah',
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: lightGreenColor, width: 0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Data harus diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 164, 186, 206),
                            blurRadius: 1,
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text("Alamat Lengkap :"),
                      ),
                      Container(
                        child: TextFormField(
                          controller: alamatTempCon,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(3, 3, 3, 0),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Alamat Ibadah',
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: lightGreenColor, width: 0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Data harus diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 164, 186, 206),
                            blurRadius: 1,
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text("Hamba Tuhan :"),
                      ),
                      Container(
                        child: TextFormField(
                          controller: hambaTuhanTempCon,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(3, 3, 3, 0),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Hamba Tuhan',
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: lightGreenColor, width: 0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Data harus diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 164, 186, 206),
                            blurRadius: 1,
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text("Worship Leader :"),
                      ),
                      Container(
                        child: TextFormField(
                          controller: wlTempCon,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(3, 3, 3, 0),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Worship Leader',
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: lightGreenColor, width: 0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Data harus diisi";
                            } else {
                              return null;
                            }
                          },
                        ),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 164, 186, 206),
                            blurRadius: 1,
                          ),
                        ]),
                      ),
                      argument == "ibadah_minggu"
                          ? Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text("Singer :"),
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: singerTempCon,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(3, 3, 3, 0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Singer',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: lightGreenColor, width: 0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Data harus diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 164, 186, 206),
                                      blurRadius: 1,
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text("Pemain Musik :"),
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: pmusikTempCon,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(3, 3, 3, 0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Pemain Musik',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: lightGreenColor, width: 0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Data harus diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 164, 186, 206),
                                      blurRadius: 1,
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text("P. Kolekte :"),
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: pkolekteTempCon,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(3, 3, 3, 0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'P.Kolekte',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: lightGreenColor, width: 0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Data harus diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 164, 186, 206),
                                      blurRadius: 1,
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text("Penerima Tamu :"),
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: ptamuTempCon,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(3, 3, 3, 0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Penerima Tamu',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: lightGreenColor, width: 0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Data harus diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 164, 186, 206),
                                      blurRadius: 1,
                                    ),
                                  ]),
                                ),
                              ],
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 25),
                          primary: Colors.teal[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          Get.showOverlay(
                              asyncFunction: () =>
                                  simpanTemp(context, argument),
                              loadingWidget: Loader());
                        },
                        child: Text(
                          "Simpan",
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        child: Text('Batalkan'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future simpanTemp_ibadahminggu(context) async {
    box.write("ibadah_minggu", {
      "jam": "${jamTempCon.text}",
      "lokasi": "${lokasiTempCon.text}",
      "alamat": "${alamatTempCon.text}",
      "hambatuhan": "${hambaTuhanTempCon.text}",
      "wl": "${wlTempCon.text}",
      "singer": "${singerTempCon.text}",
      "pmusik": "${pmusikTempCon.text}",
      "pkolekte": "${pkolekteTempCon.text}",
      "ptamu": "${ptamuTempCon.text}",
    });
    Snackbar_top(
        title: "Sukses",
        message: "Berhasil Merubah Template",
        kategori: "success",
        duration: 1);
    Navigator.pop(context);
  }

  void salinMingguTemp() async {
    var tmp_ibadahminggu = box.read("ibadah_minggu");
    logInfo(tmp_ibadahminggu['singer']);
    jamCon.text = tmp_ibadahminggu['jam'];
    lokasiCon.text = tmp_ibadahminggu['lokasi'];
    alamatCon.text = tmp_ibadahminggu['alamat'];
    hambaTuhanCon.text = tmp_ibadahminggu['hambatuhan'];
    wlCon.text = tmp_ibadahminggu['wl'];
    singerCon.text = tmp_ibadahminggu['singer'];
    pmusikCon.text = tmp_ibadahminggu['pmusik'];
    pkolekteCon.text = tmp_ibadahminggu['pkolekte'];
    ptamuCon.text = tmp_ibadahminggu['ptamu'];
  }

  Future simpanTemp(context, jenis_ibadah) async {
    box.write("${jenis_ibadah}", {
      "jam": "${jamTempCon.text}",
      "lokasi": "${lokasiTempCon.text}",
      "alamat": "${alamatTempCon.text}",
      "hambatuhan": "${hambaTuhanTempCon.text}",
      "wl": "${wlTempCon.text}",
      "singer": "${singerTempCon.text}",
      "pmusik": "${pmusikTempCon.text}",
      "pkolekte": "${pkolekteTempCon.text}",
      "ptamu": "${ptamuTempCon.text}",
    });
    Snackbar_top(
        title: "Sukses",
        message: "Berhasil Merubah Template",
        kategori: "success",
        duration: 1);
    Navigator.pop(context);
  }

  void salinTemp(jenis_ibadah) async {
    var tmp_ibadahminggu = box.read("${jenis_ibadah}");

    jamCon.text = tmp_ibadahminggu['jam'];
    lokasiCon.text = tmp_ibadahminggu['lokasi'];
    alamatCon.text = tmp_ibadahminggu['alamat'];
    hambaTuhanCon.text = tmp_ibadahminggu['hambatuhan'];
    wlCon.text = tmp_ibadahminggu['wl'];
    singerCon.text = tmp_ibadahminggu['singer'];
    pmusikCon.text = tmp_ibadahminggu['pmusik'];
    pkolekteCon.text = tmp_ibadahminggu['pkolekte'];
    ptamuCon.text = tmp_ibadahminggu['ptamu'];
  }

  void loadTemp(jenis_ibadah) async {
    var tmp_ibadahminggu = box.read("${jenis_ibadah}");

    jamTempCon.text = tmp_ibadahminggu['jam'];
    lokasiTempCon.text = tmp_ibadahminggu['lokasi'];
    alamatTempCon.text = tmp_ibadahminggu['alamat'];
    hambaTuhanTempCon.text = tmp_ibadahminggu['hambatuhan'];
    wlTempCon.text = tmp_ibadahminggu['wl'];
    singerCon.text = tmp_ibadahminggu['singer'];
    pmusikCon.text = tmp_ibadahminggu['pmusik'];
    pkolekteCon.text = tmp_ibadahminggu['pkolekte'];
    ptamuCon.text = tmp_ibadahminggu['ptamu'];
  }

  void loadTemp_ibadahminggu(jenis_ibadah) async {
    var tmp_ibadahminggu = box.read("${jenis_ibadah}");

    jamTempCon.text = tmp_ibadahminggu['jam'];
    lokasiTempCon.text = tmp_ibadahminggu['lokasi'];
    alamatTempCon.text = tmp_ibadahminggu['alamat'];
    hambaTuhanTempCon.text = tmp_ibadahminggu['hambatuhan'];
    wlTempCon.text = tmp_ibadahminggu['wl'];
    singerCon.text = tmp_ibadahminggu['singer'];
    pmusikCon.text = tmp_ibadahminggu['pmusik'];
    pkolekteCon.text = tmp_ibadahminggu['pkolekte'];
    ptamuCon.text = tmp_ibadahminggu['ptamu'];
  }

  void loadEdit({required ModelJadwal model}) async {
    DateTime? parsedDate = DateTime.tryParse("${model.tanggal}");
    tanggalCon.text = DateFormat('yyyy-MM-dd').format(parsedDate!);
    jamCon.text = model.jam;
    lokasiCon.text = model.lokasi;
    alamatCon.text = model.alamat;
    hambaTuhanCon.text = model.hambaTuhan;
    wlCon.text = model.wl;
    singerCon.text = model.singer;
    pmusikCon.text = model.pmusik;
    pkolekteCon.text = model.pkolekte;
    ptamuCon.text = model.ptamu;
  }
}
