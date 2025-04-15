import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/broadcast_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/widgets/topline_bottomsheet.dart';

import 'package:sizer/sizer.dart';

class broadcastAdmin extends StatefulWidget {
  broadcastAdmin({super.key});

  @override
  State<broadcastAdmin> createState() => _broadcastAdminState();
}

class _broadcastAdminState extends State<broadcastAdmin> {
  final home_controller2 session_C = Get.find();

  final broadcast_Controller controller = Get.put(broadcast_Controller());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Broadcast Notifikasi", leading: true),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      topline_bottomsheet(),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          "Pilih Target :",
                        ),
                      ),
                      Obx(() => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButton(
                              hint: Text(
                                'Pilih Target',
                              ),
                              onChanged: (newValue) {
                                controller.changevalue(
                                    value: newValue.toString());
                              },
                              value: controller.selected,
                              items: <String>[
                                'user',
                                'hambatuhan',
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Container(
                              child: TextFormField(
                                controller: controller.judulController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Masukan Judul ',
                                  labelText: 'Judul Notifikasi *',
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
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
                                controller: controller.isiController,
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
                                  hintText: 'Masukan Isi Notifikasi',
                                  labelText: 'Isi Notifikasi *',
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "Upload Gambar (Jika Ada) :",
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () => {controller.PilihPicker()},
                                    child: GetBuilder<broadcast_Controller>(
                                      // specify type as Controller
                                      init:
                                          broadcast_Controller(), // intialize with the Controller
                                      builder: (value) => Container(
                                          width: 110,
                                          height: 90,
                                          child: (controller.image == null)
                                              ? Image.asset(
                                                  "assets/images/default-img.png")
                                              : Image.file(
                                                  File(controller.pathImage))),
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
                            width: 30.w,
                            child: OutlinedButton.icon(
                                //Handle button press event
                                onPressed: () {
                                  controller.CheckTambah(controller.selected);
                                },
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    color: lightBlueColor,
                                    width: 1,
                                  ),
                                  onPrimary: lightBlueColor,
                                ),
                                icon: const Icon(Icons.save_alt),
                                label: const Text("Kirim")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.notification_important),
            onPressed: () {
              controller.testing();
            },
          ),
        ),
      ],
    );
  }
}
