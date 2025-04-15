import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/common/styles.dart';
import 'package:gpdikpbaru/controller/admin/inputlive_controller.dart';
import 'package:gpdikpbaru/widgets/topline_bottomsheet.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

tambahlive_bottom(
    {required BuildContext context, required String Id, required String aksi}) {
  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  final inputLiveController renungan_C = Get.find();
  Get.bottomSheet(
    isDismissible: aksi == "input" ? true : false,
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Form(
            key: renungan_C.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topline_bottomsheet(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Text(
                            "Pastikan Anda telah status Live Streaming di Youtube terlebih dahulu, baru input Live Streaming disini",
                            style: defaultFontBold),
                        SizedBox(height: 3.h),
                        Text("Judul Live Streaming"),
                        Container(
                          child: TextFormField(
                            controller: renungan_C.judul_liveCon,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Masukan Judul Renungan',
                              labelText: 'Judul *',
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: lightGreenColor, width: 2),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 164, 186, 206),
                              blurRadius: 5,
                            ),
                          ]),
                        ),
                        SizedBox(height: 15),
                        Text(
                            "ID Video terdapat pada (youtube.com/watch?v='ID_YOUTUBE')"),
                        Container(
                          child: TextFormField(
                            controller: renungan_C.url_liveCon,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Masukan Url Youtube',
                              labelText: 'ID URL Youtube ',
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: lightGreenColor, width: 2),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 164, 186, 206),
                              blurRadius: 5,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 40.w,
                        child: OutlinedButton.icon(
                            //Handle button press event
                            onPressed: () {
                              renungan_C.CheckInput(aksi: aksi, id_khotbah: Id);
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: lightBlueColor,
                                width: 1,
                              ),
                              onPrimary: lightBlueColor,
                            ),
                            icon: const Icon(Icons.save_alt),
                            label: const Text("Simpan")),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: OutlinedButton.icon(
                            //Handle button press event
                            onPressed: () {
                              Get.back();
                              renungan_C.hapusisi();
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: lightRedColor,
                                width: 1,
                              ),
                              onPrimary: lightRedColor,
                            ),
                            icon: const Icon(Icons.cached_rounded),
                            label: const Text("Batal")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
