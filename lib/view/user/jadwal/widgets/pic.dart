import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart';
import 'package:sizer/sizer.dart';

class WidgetPIC extends StatelessWidget {
  final ModelJadwal modelJadwal;
  const WidgetPIC({Key? key, required this.modelJadwal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themedark theme = Get.find();
    const text_tablepic1 = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
    );
    const text_tablepic2 = TextStyle(
      fontSize: 11,
    );
    return DraggableScrollableSheet(
        initialChildSize: 0.08,
        minChildSize: 0.08,
        maxChildSize: 0.7,
        builder: (context, myScrollController) {
          return Obx(() => Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color:
                              theme.isLightTheme.value ? CtrWhite : CtrBlack2,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.2),
                                offset: Offset(0, -3),
                                blurRadius: 8)
                          ]),
                      width: 100.w,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        controller: myScrollController,
                        children: [
                          SizedBox(height: 1.h),
                          Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "Laporan Ibadah (PIC)",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[300]),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          Center(
                              child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 162, 209, 210)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Table(
                              border: TableBorder(
                                  horizontalInside: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 162, 209, 210)),
                                  verticalInside: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 162, 209, 210)),
                                  right: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 162, 209, 210))),
                              columnWidths: const {
                                0: FixedColumnWidth(80),
                                1: FlexColumnWidth(130),
                                2: FlexColumnWidth(130),
                              },
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('08.30-09.30',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Penyambutan',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.penyambutan}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('08.30-08.45',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        'Persiapan Sound/Musik/Multimedia',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.persiapanAcara}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('08.45-09.00',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Doa Pelayan',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.doaPelayan}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('09.00-09.45',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Praise & Worship',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.praise}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('', style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Doa Pembukaan',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.doaPembukaan}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('', style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:
                                        Text('Pujian', style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.pujian}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('', style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Doa Firman',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.doaFirman}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('09.45-10.30',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Perberitaan Firman Tuhan',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.firmanTuhan}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('09.45-10.30',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Philadelphia Berdoa',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.phBerdoa}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('10.30-10.35',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Doa Berkat',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.doaBerkat}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('10.35.-11.00',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Kesaksian',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.kesaksian}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('11.00-11.10',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        'Pembacaan Ayat & Doa Persembahan',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.bacaAyat}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('11.10-11.20',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Persembahan & Pengumuman',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('${modelJadwal.persembahan}',
                                        style: text_tablepic2),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('11.20-11.30',
                                        style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:
                                        Text('Selesai', style: text_tablepic1),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('', style: text_tablepic2),
                                  ),
                                ]),
                              ],
                            ),
                          )),
                          SizedBox(height: 1.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: "Jumlah Jemaat :",
                                    labelStyle: TextStyle(
                                        color: Colors.teal[200],
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal),
                                    ),
                                  ),
                                  initialValue: "${modelJadwal.jumJemaat}",
                                ),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: "Jemaat Baru :",
                                    labelStyle: TextStyle(
                                        color: Colors.teal[200],
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal),
                                    ),
                                  ),
                                  initialValue: "${modelJadwal.jumBaru}",
                                ),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: "Kesaksian :",
                                    labelStyle: TextStyle(
                                        color: Colors.teal[200],
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal),
                                    ),
                                  ),
                                  initialValue: "${modelJadwal.kesaksian}",
                                ),
                                TextFormField(
                                  enabled: false,
                                  minLines:
                                      5, // any number you need (It works as the rows for the textarea)
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    labelText: "Evaluasi :",
                                    labelStyle: TextStyle(
                                        color: Colors.teal[200],
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal),
                                    ),
                                  ),
                                  initialValue: "${modelJadwal.evaluasi}",
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ));
        });
  }
}
