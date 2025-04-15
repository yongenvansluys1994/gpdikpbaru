import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/materi/inputmateri_controller.dart';
import 'package:gpdikpbaru/widgets/topline_bottomsheet.dart';

import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

tambahmateri_bottom(
    {required BuildContext context, required String Id, required String aksi}) {
  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  final inputMateriController controller = Get.find();
  Get.bottomSheet(
    isDismissible: aksi == "input" ? true : false,
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: 35.h,
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
            key: controller.formKey,
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
                            controller: controller.nama_file,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Nama Materi',
                              labelText: 'Nama Materi *',
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
                          child: DropdownButtonFormField<String>(
                            value: controller.selectedKategori
                                .value, // Nilai awal dari controller
                            onChanged: (newValue) {
                              controller.selectedKategori.value =
                                  newValue!; // Update nilai terpilih
                            },
                            items: [
                              DropdownMenuItem(
                                value: "Ibadah",
                                child: Text("Ibadah"),
                              ),
                              DropdownMenuItem(
                                value: "Komsel",
                                child: Text("Komsel"),
                              ),
                            ],
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Pilih Kategori',
                              labelText: 'Kategori *',
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
                                "Upload File Materi : *Harus PDF",
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {controller.filePicker(context)},
                              child: GetBuilder<inputMateriController>(
                                init:
                                    inputMateriController(), // Inisialisasi controller
                                builder: (value) => Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 90,
                                        child: (controller.pathFile
                                                .isNotEmpty) // Periksa apakah file sudah dipilih
                                            ? Icon(Icons.picture_as_pdf,
                                                size: 16.w,
                                                color: Colors
                                                    .red) // Tampilkan ikon PDF
                                            : Image.asset(
                                                "assets/images/default-img.png"), // Tampilkan gambar default
                                      ),
                                      if (controller.pathFile
                                          .isNotEmpty) // Jika file sudah dipilih
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              controller.pathFile
                                                  .split('/')
                                                  .last, // Menampilkan nama file
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                              overflow: TextOverflow
                                                  .ellipsis, // Jika nama file terlalu panjang
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                              controller.CheckInput(
                                  aksi: aksi, id_kegiatan: Id);
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
                              controller.hapusisi();
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
