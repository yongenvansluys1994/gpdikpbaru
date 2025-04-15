import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/persembahan/persembahan_controller.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

tambahkolekte_bottom({String? text, int? addEditFlag, String? docId}) {
  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  final Persembahan_Controller persembahan_C = Get.find();
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
            key: persembahan_C.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 12.w,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Container(
                            child: TextFormField(
                          controller: persembahan_C.namaController,
                          decoration: const InputDecoration(
                            hintText: 'Masukan Nama Anda',
                            labelText: 'Nama *',
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white, //<-- SEE HERE
                          ),
                        )),
                        SizedBox(height: 15),
                        Container(
                            child: TextFormField(
                          controller: persembahan_C.nominalController,
                          decoration: const InputDecoration(
                            hintText: 'Masukan Nominal Kolekte',
                            labelText: 'Nominal *',
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white, //<-- SEE HERE
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (string) {
                            string = '${formNum(
                              string.replaceAll(',', ''),
                            )}';
                            persembahan_C.nominalController.value =
                                TextEditingValue(
                              text: string,
                              selection: TextSelection.collapsed(
                                offset: string.length,
                              ),
                            );
                          },
                        )),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            "Pembayaran Melalui :",
                          ),
                        ),
                        SizedBox(height: 15),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('data_bank')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            // Safety check to ensure that snapshot contains data
                            // without this safety check, StreamBuilder dirty state warnings will be thrown
                            if (!snapshot.hasData) return Container();
                            // Set this value for default,
                            // setDefault will change if an item was selected
                            // First item from the List will be displayed
                            if (true) {
                              persembahan_C.changeprevaluebank(
                                  prevaluebank:
                                      snapshot.data!.docs[0].get('postID'));
                              persembahan_C.changevaluebank(
                                  valuebank:
                                      snapshot.data!.docs[0].get('postID'));
                            }
                            return Obx(() => DropdownButton(
                                  isExpanded: false,
                                  value: persembahan_C.prevaluebank,
                                  items: snapshot.data!.docs.map((value) {
                                    return DropdownMenuItem(
                                      value: value.get('postID'),
                                      child: Text('${value.get('nama_bank')}'),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    debugPrint('selected onchange: ');
                                    persembahan_C.changevaluebank(
                                        valuebank: value.toString());

                                    persembahan_C.changeprevaluebank(
                                        prevaluebank: value.toString());
                                  },
                                ));
                          },
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
                            persembahan_C.CheckTambah(
                                persembahan_C.namaController.text,
                                persembahan_C.nominalController.text,
                                docId!,
                                addEditFlag!);
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
