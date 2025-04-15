import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/inputcontactperson_controller.dart';
import 'package:gpdikpbaru/widgets/topline_bottomsheet.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

tambah_bottom(
    {required BuildContext context, required int Id, required String aksi}) {
  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  final inputContactPersonController contactperson_C = Get.find();
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
            key: contactperson_C.formKey,
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
                        Container(
                          child: TextFormField(
                            controller: contactperson_C.NamaCon,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Masukan Nama Lengkap',
                              labelText: 'Nama *',
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
                        Container(
                          child: TextFormField(
                            controller: contactperson_C.No_HPCon,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'No_HP',
                              labelText: 'Nama *',
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
                        Container(
                          child: TextFormField(
                            controller: contactperson_C.AlamatCon,
                            minLines:
                                5, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: null,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Masukan Alamat',
                              labelText: 'Alamat *',
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
                        Container(
                          child: TextFormField(
                            controller: contactperson_C.KetCon,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Masukkan Keterangan/Jabatan',
                              labelText: 'Keterangan/Jabatan *',
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "Upload Foto :",
                              ),
                            ),
                            GestureDetector(
                                onTap: () => {contactperson_C.PilihPicker()},
                                child: GetBuilder<inputContactPersonController>(
                                  // specify type as Controller
                                  init:
                                      inputContactPersonController(), // intialize with the Controller
                                  builder: (value) => Container(
                                      width: 110,
                                      height: 90,
                                      child: (contactperson_C.image_url != "")
                                          ? Image.network(
                                              contactperson_C.image_url.value)
                                          : (contactperson_C.image == null)
                                              ? Image.asset(
                                                  "assets/images/default-img.png")
                                              : Image.file(File(
                                                  contactperson_C.pathImage))),
                                )),
                          ],
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
                              contactperson_C.CheckInput(aksi: aksi, id: Id);
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
                              contactperson_C.hapusisi();
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
