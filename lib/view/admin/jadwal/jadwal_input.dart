import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/inputjadwal_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/view/user/jadwal/widgets/jadwal_card.dart';
import 'package:gpdikpbaru/widgets/dismiss_keyboard.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:gpdikpbaru/widgets/snackbar.dart';

import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class jadwalInputAdmin extends StatelessWidget {
  final inputC = Get.put(inputJadwalController());
  final home_controller2 session_C = Get.find();
  var arguments = Get.arguments;
  final formKey = GlobalKey<FormState>();
  jadwalInputAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            extendBodyBehindAppBar: false,
            appBar:
                CustomAppBar(title: "Jadwal ${arguments[1]}", leading: true),
            body: GestureDetector(
              onTap: () {
                dismissKeyboard();
              },
              child: Form(
                key: formKey,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${arguments[1]}",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.transparent),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 82.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  offset: Offset(0, -4),
                                  blurRadius: 8)
                            ]),
                        child: ListView(
                          children: [
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 25),
                                    primary: Colors.teal[200],
                                    onPrimary: Colors.white, // foreground
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (arguments[0] == "ibadah_minggu") {
                                      // logInfo("asdasdasda");
                                      inputC.salinMingguTemp();
                                    } else {
                                      inputC.salinTemp(arguments[0]);
                                    }
                                  },
                                  child: Text(
                                    "Salin Template",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 25),
                                    primary: Colors.redAccent.withOpacity(0.5),
                                    onPrimary: Colors.white, // foreground
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    inputC.showDialogTemp(
                                        context, arguments[0]);
                                  },
                                  child: Text(
                                    "Ubah Template",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   "IBADAH MINGGU PAGI",
                                  //   style: TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Color.fromARGB(255, 37, 37, 37)),
                                  // ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Icon(
                                          Icons.access_time,
                                          size: 20,
                                          color: textColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: TextFormField(
                                            controller: inputC.tanggalCon,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5.sp, 5.sp, 5.sp, 0),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: 'Tanggal Ibadah',
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.0),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightGreenColor,
                                                    width: 0),
                                              ),
                                            ),
                                            readOnly:
                                                true, //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: arguments[3],
                                                      firstDate: arguments[
                                                          2], //DateTime.now() - not to allow to choose before today.
                                                      lastDate: arguments[3]);

                                              if (pickedDate != null) {
                                                print(
                                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickedDate);
                                                print(
                                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                                //you can implement different kind of Date Format here according to your requirement
                                                inputC.changevaluetanggal(
                                                    formattedDate:
                                                        formattedDate);
                                              } else {
                                                print("Date is not selected");
                                              }
                                            },
                                          ),
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 164, 186, 206),
                                              blurRadius: 1,
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Icon(
                                          Icons.access_time,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: TextFormField(
                                            controller: inputC.jamCon,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5.sp, 5.sp, 5.sp, 0),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: 'Jam Ibadah',
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.0),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightGreenColor,
                                                    width: 0),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 164, 186, 206),
                                              blurRadius: 1,
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 20,
                                          color: textColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: TextFormField(
                                            controller: inputC.lokasiCon,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5.sp, 5.sp, 5.sp, 0),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: 'Lokasi',
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.0),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightGreenColor,
                                                    width: 0),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 164, 186, 206),
                                              blurRadius: 1,
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: TextFormField(
                                            controller: inputC.alamatCon,
                                            minLines:
                                                2, // any number you need (It works as the rows for the textarea)
                                            keyboardType:
                                                TextInputType.multiline,
                                            textInputAction:
                                                TextInputAction.newline,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      5.sp, 5.sp, 5.sp, 0),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: 'Alamat',
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.0),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightGreenColor,
                                                    width: 0),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 164, 186, 206),
                                              blurRadius: 1,
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Center(
                                    child: Text(
                                      "Susunan Pelayan",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal[200]),
                                    ),
                                  ),
                                  Center(
                                      child: Container(
                                    margin: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 162, 209, 210)),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Table(
                                      border: TableBorder(
                                          horizontalInside: BorderSide(
                                              width: 2,
                                              color: Color.fromARGB(
                                                  255, 162, 209, 210)),
                                          verticalInside: BorderSide(
                                              width: 2,
                                              color: Color.fromARGB(
                                                  255, 162, 209, 210)),
                                          right: BorderSide(
                                              width: 2,
                                              color: Color.fromARGB(
                                                  255, 162, 209, 210))),
                                      columnWidths: const {
                                        0: FixedColumnWidth(130),
                                        1: FlexColumnWidth(),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Hamba Tuhan',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Container(
                                              child: TextFormField(
                                                controller:
                                                    inputC.hambaTuhanCon,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          5.sp, 5.sp, 5.sp, 0),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: 'Hamba Tuhan',
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightGreenColor,
                                                        width: 0),
                                                  ),
                                                ),
                                              ),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 164, 186, 206),
                                                  blurRadius: 1,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Worship Leader',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Container(
                                              child: TextFormField(
                                                controller: inputC.wlCon,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          5.sp, 5.sp, 5.sp, 0),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: 'Worship Leader',
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightGreenColor,
                                                        width: 0),
                                                  ),
                                                ),
                                              ),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 164, 186, 206),
                                                  blurRadius: 1,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ]),
                                        arguments[0] == "ibadah_minggu"
                                            ? TableRow(children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Singer',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: TextFormField(
                                                      controller:
                                                          inputC.singerCon,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                5.sp,
                                                                5.sp,
                                                                5.sp,
                                                                0),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintText: 'Singer',
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.0),
                                                        ),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreenColor,
                                                              width: 0),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    164,
                                                                    186,
                                                                    206),
                                                            blurRadius: 1,
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              ])
                                            : TableRow(children: [
                                                SizedBox(),
                                                SizedBox()
                                              ]),
                                        arguments[0] == "ibadah_minggu"
                                            ? TableRow(children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Pemain Musik',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: TextFormField(
                                                      controller:
                                                          inputC.pmusikCon,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                5.sp,
                                                                5.sp,
                                                                5.sp,
                                                                0),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintText:
                                                            'Pemain Musik',
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.0),
                                                        ),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreenColor,
                                                              width: 0),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    164,
                                                                    186,
                                                                    206),
                                                            blurRadius: 1,
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              ])
                                            : TableRow(children: [
                                                SizedBox(),
                                                SizedBox()
                                              ]),
                                        arguments[0] == "ibadah_minggu"
                                            ? TableRow(children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('P.Kolekte',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: TextFormField(
                                                      controller:
                                                          inputC.pkolekteCon,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                5.sp,
                                                                5.sp,
                                                                5.sp,
                                                                0),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintText: 'P. Kolekte',
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.0),
                                                        ),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreenColor,
                                                              width: 0),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    164,
                                                                    186,
                                                                    206),
                                                            blurRadius: 1,
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              ])
                                            : TableRow(children: [
                                                SizedBox(),
                                                SizedBox()
                                              ]),
                                        arguments[0] == "ibadah_minggu"
                                            ? TableRow(children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('Pen.Tamu',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: TextFormField(
                                                      controller:
                                                          inputC.ptamuCon,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                5.sp,
                                                                5.sp,
                                                                5.sp,
                                                                0),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintText:
                                                            'Penerima Tamu',
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.0),
                                                        ),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreenColor,
                                                              width: 0),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    164,
                                                                    186,
                                                                    206),
                                                            blurRadius: 1,
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              ])
                                            : TableRow(children: [
                                                SizedBox(),
                                                SizedBox()
                                              ]),
                                      ],
                                    ),
                                  )),
                                  SizedBox(height: 2.h),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 85.w, // <-- Your width
                                            height: 32, // <-- Your height
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(150, 43),
                                                  primary: Colors.teal[200],
                                                  onPrimary: Colors.white,
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  inputC.CheckInput(
                                                      title: arguments[1],
                                                      kategori: arguments[0],
                                                      aksi: "input",
                                                      id_jadwal: '');
                                                },
                                                child: Stack(
                                                  children: <Widget>[
                                                    // Stroked text as border.

                                                    Text(
                                                      'Simpan Jadwal Ibadah',
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 20),
                              child: Row(
                                children: [],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
