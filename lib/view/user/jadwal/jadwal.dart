import 'package:flutter/material.dart';
import 'package:gpdikpbaru/common/responsive.dart';
import 'package:gpdikpbaru/common/styles.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/view/user/jadwal/widgets/jadwal_card.dart';
import 'package:gpdikpbaru/view/user/jadwal/widgets/jadwal_card_doa.dart';
import 'package:gpdikpbaru/view/user/jadwal/widgets/jadwal_card_pelprap.dart';
import 'package:gpdikpbaru/view/user/jadwal/widgets/jadwal_card_pelprip.dart';
import 'package:gpdikpbaru/view/user/jadwal/widgets/jadwal_card_pelwap.dart';
import 'package:sizer/sizer.dart';

class Jadwal extends StatelessWidget {
  Jadwal({Key? key}) : super(key: key);

  final List<Map<String, String>> categories = [
    {"title": "IBADAH RAYA MINGGU", "kategori": "ibadah_minggu"},
    {"title": "IBADAH PELPRIP", "kategori": "ibadah_pelprip"},
    {"title": "IBADAH PELWAP", "kategori": "ibadah_pelwap"},
    {"title": "IBADAH PELPRAP", "kategori": "ibadah_pelprap"},
    {"title": "DOA PERSEKUTUAN", "kategori": "doa_persekutuan"},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Jadwal", leading: true),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: categories.map((category) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10),
                            child: Text(
                              category["title"]!,
                              style: defaultFontMed.copyWith(
                                fontSize: Responsive.FONT_SIZE_LARGE,
                              ),
                            ),
                          ),
                          Wrap(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 5),
                                child: Text(
                                  "Lihat Semua",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 80, 162, 229),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      //jadwalCard2(kategori: category["kategori"]!),
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
