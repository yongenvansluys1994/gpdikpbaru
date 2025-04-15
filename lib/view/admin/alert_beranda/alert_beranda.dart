import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/alert_beranda_controller.dart';

import 'package:gpdikpbaru/controller/home_controller2.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_switch/flutter_switch.dart';

class alertBeranda extends StatefulWidget {
  alertBeranda({super.key});

  @override
  State<alertBeranda> createState() => _alertBerandaState();
}

class _alertBerandaState extends State<alertBeranda> {
  final home_controller2 session_C = Get.find();

  final alertBeranda_Controller controller = Get.put(alertBeranda_Controller());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar:
              CustomAppBar(title: "Radio Rohani Admin Panel", leading: true),
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
                                minLines:
                                    2, // any number you need (It works as the rows for the textarea)
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Masukan Judul Pemberitahuan',
                                  labelText: 'Judul Pemberitahuan *',
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
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              controller.CheckTambah();
                            },
                            child: Text("Simpan Data")),
                      )
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
