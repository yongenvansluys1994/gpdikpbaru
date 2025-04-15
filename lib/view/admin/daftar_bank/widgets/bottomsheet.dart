import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/bank_controller.dart';
import 'package:gpdikpbaru/widgets/topline_bottomsheet.dart';
import 'package:sizer/sizer.dart';

tambahbank_bottom(
    {required BuildContext context,
    required String postID,
    required String aksi}) {
  final Bank_Controller bank_C = Get.find();
  Get.bottomSheet(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
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
            key: bank_C.formKey,
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
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text("Jenis Rekening * "),
                        ),
                        Obx(() => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButton(
                                onChanged: (newValue) {
                                  bank_C.changevalue(
                                      value: newValue.toString());
                                },
                                value: bank_C.selectedjenis,
                                items: <String>[
                                  'Bank',
                                  'Dompet Digital',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      value,
                                    ),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            )),
                        Container(
                            child: TextFormField(
                          controller: bank_C.namabankController,
                          decoration: const InputDecoration(
                            hintText: 'Masukan Nama Bank',
                            labelText: 'Nama Bank *',
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white, //<-- SEE HERE
                          ),
                        )),
                        Container(
                            child: TextFormField(
                          controller: bank_C.norekController,
                          decoration: const InputDecoration(
                            hintText: 'Masukan No Rekening',
                            labelText: 'No Rekening *',
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white, //<-- SEE HERE
                          ),
                        )),
                        Container(
                            child: TextFormField(
                          controller: bank_C.namarekController,
                          decoration: const InputDecoration(
                            hintText: 'Masukan Nama Pemilik Rekening',
                            labelText: 'Nama Pemilik Rekening *',
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white, //<-- SEE HERE
                          ),
                        )),
                        Container(
                            child: TextFormField(
                          controller: bank_C.carabayarController,
                          decoration: const InputDecoration(
                            hintText: 'Masukan Cara Bayar',
                            labelText: 'Cara Bayar *',
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white, //<-- SEE HERE
                          ),
                        )),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "Upload Gambar/Logo Bank :",
                              ),
                            ),
                            GestureDetector(
                                onTap: () => {bank_C.openCameraGereja()},
                                child: GetBuilder<Bank_Controller>(
                                  // specify type as Controller
                                  init:
                                      Bank_Controller(), // intialize with the Controller
                                  builder: (value) => Container(
                                      width: 110,
                                      height: 90,
                                      child: (bank_C.pathImage == "")
                                          ? Image.asset(
                                              "assets/images/default-img.png")
                                          : Image.file(File(bank_C.pathImage))),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: Get.context!.width, height: 45),
                    child: SizedBox(
                      width: 30.w,
                      child: OutlinedButton.icon(
                          //Handle button press event
                          onPressed: () {
                            bank_C.CheckInput(
                                aksi: aksi, postID: postID, image: "");
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
