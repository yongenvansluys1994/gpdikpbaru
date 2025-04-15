import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/inputjadwal_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';

import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class jadwalEditAdmin extends StatefulWidget {
  final ModelJadwal dataJadwal;
  jadwalEditAdmin({
    super.key,
    required this.dataJadwal,
  });

  @override
  State<jadwalEditAdmin> createState() => _jadwalEditAdminState();
}

class _jadwalEditAdminState extends State<jadwalEditAdmin> {
  final inputC = Get.put(inputJadwalController());

  final home_controller2 session_C = Get.find();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    inputC.loadEdit(model: widget.dataJadwal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: CustomAppBar(title: "Edit Jadwal", leading: true),
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: const Offset(0, -4),
                      blurRadius: 8,
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
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
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Salin Template",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 25),
                              primary: Colors.redAccent.withOpacity(0.5),
                              onPrimary: Colors.white, // foreground
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              // inputC.showDialogTemp(context, "asd");
                            },
                            child: Text(
                              "Ubah Template",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
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
                                  padding: const EdgeInsets.only(right: 7),
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
                                            EdgeInsets.fromLTRB(3, 3, 3, 0),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Tanggal Ibadah',
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightGreenColor, width: 0),
                                        ),
                                      ),
                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(
                                                    2000), //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2101));

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
                                              formattedDate: formattedDate);
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 164, 186, 206),
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
                                  padding: const EdgeInsets.only(right: 7),
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
                                            EdgeInsets.fromLTRB(3, 3, 3, 0),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Jam Ibadah',
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightGreenColor, width: 0),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 164, 186, 206),
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
                                  padding: const EdgeInsets.only(right: 7),
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
                                            EdgeInsets.fromLTRB(3, 3, 3, 0),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Lokasi',
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightGreenColor, width: 0),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 164, 186, 206),
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
                                  padding: const EdgeInsets.only(right: 7),
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
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(3, 3, 3, 0),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Alamat',
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightGreenColor, width: 0),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 164, 186, 206),
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
                                      color:
                                          Color.fromARGB(255, 162, 209, 210)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: IntrinsicHeight(
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
                                              255, 162, 209, 210)),
                                    ),
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
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            child: TextFormField(
                                              controller: inputC.hambaTuhanCon,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        3, 3, 3, 0),
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
                                                  fontWeight: FontWeight.bold)),
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
                                                        3, 3, 3, 0),
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
                                      widget.dataJadwal.kategori ==
                                              "ibadah_minggu"
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
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              3, 3, 3, 0),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      hintText: 'Singer',
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey,
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
                                            ])
                                          : TableRow(children: [
                                              SizedBox.shrink(),
                                              SizedBox.shrink()
                                            ]),
                                      widget.dataJadwal.kategori ==
                                              "ibadah_minggu"
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
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              3, 3, 3, 0),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      hintText: 'Pemain Musik',
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey,
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
                                            ])
                                          : TableRow(children: [
                                              SizedBox(),
                                              SizedBox()
                                            ]),
                                      widget.dataJadwal.kategori ==
                                              "ibadah_minggu"
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
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              3, 3, 3, 0),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      hintText: 'P. Kolekte',
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey,
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
                                            ])
                                          : TableRow(children: [
                                              SizedBox(),
                                              SizedBox()
                                            ]),
                                      widget.dataJadwal.kategori ==
                                              "ibadah_minggu"
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
                                                    controller: inputC.ptamuCon,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              3, 3, 3, 0),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      hintText: 'Penerima Tamu',
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey,
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
                                            ])
                                          : TableRow(children: [
                                              SizedBox(),
                                              SizedBox()
                                            ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 85.w, // <-- Your width
                                      height: 32, // <-- Your height
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(150, 43),
                                            primary: Colors.teal[200],
                                            onPrimary: Colors.white,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            inputC.CheckInput(
                                                title: "",
                                                kategori:
                                                    widget.dataJadwal.kategori,
                                                aksi: "edit",
                                                id_jadwal:
                                                    widget.dataJadwal.idJadwal);
                                          },
                                          child: Stack(
                                            children: <Widget>[
                                              // Stroked text as border.

                                              Text(
                                                'Ubah Data',
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 85.w, // <-- Your width
                                      height: 32, // <-- Your height
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(150, 43),
                                            primary: Color.fromARGB(
                                                255, 207, 207, 207),
                                            onPrimary: Colors.white,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            inputC.hapusisicontroller();
                                            Get.back();
                                          },
                                          child: Stack(
                                            children: <Widget>[
                                              // Stroked text as border.

                                              Text(
                                                'Kembali',
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 15,
                          right: 15,
                        ),
                        child: Column(
                          children: [],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
