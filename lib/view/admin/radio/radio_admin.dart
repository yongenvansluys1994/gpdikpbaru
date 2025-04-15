import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/radio_admin_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/widgets/topline_bottomsheet.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_switch/flutter_switch.dart';

class radioAdmin extends StatefulWidget {
  radioAdmin({super.key});

  @override
  State<radioAdmin> createState() => _radioAdminState();
}

class _radioAdminState extends State<radioAdmin> {
  final home_controller2 session_C = Get.find();

  final radioAdmin_Controller controller = Get.put(radioAdmin_Controller());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Radio ", leading: true),
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
                                  hintText: 'Masukan Judul Sesi Radio',
                                  labelText: 'Judul Sesi Radio *',
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
                                controller: controller.urlController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Masukan Url Youtube Radio Live',
                                  labelText: 'Url Youtube Radio Live *',
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
                                    child: GetBuilder<radioAdmin_Controller>(
                                      // specify type as Controller
                                      init:
                                          radioAdmin_Controller(), // intialize with the Controller
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
                      Obx(() => Center(
                            child: FlutterSwitch(
                              width: 40.w,
                              height: 7.h,
                              valueFontSize: 25.0,
                              toggleSize: 45.0,
                              value: controller.status5,
                              activeText: "Online",
                              inactiveText: "Offline",
                              borderRadius: 30.0,
                              padding: 8.0,
                              showOnOff: true,
                              onToggle: (val) {
                                controller.switch_button(
                                    value: val, kategori: controller.selected);
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
