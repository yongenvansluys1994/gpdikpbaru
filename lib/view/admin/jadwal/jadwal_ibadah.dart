import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gpdikpbaru/controller/home_controller2.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/view/admin/jadwal/widgets/grid_jadwalibadah.dart';

import 'package:sizer/sizer.dart';

class jadwalIbadahAdmin extends StatelessWidget {
  final home_controller2 session_C = Get.find();
  jadwalIbadahAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            extendBodyBehindAppBar: false,
            appBar: CustomAppBar(title: "Jadwal Ibadah", leading: true),
            body: Container(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: GridView(
                  children: [
                    modulJadwalIbadah(
                        kategori: "ibadah_minggu", title: "Ibadah Minggu"),
                    modulJadwalIbadah(
                        kategori: "doa_persekutuan", title: "Doa Persekutuan"),
                    modulJadwalIbadah(
                        kategori: "ibadah_pelprip", title: "Ibadah Pelprip"),
                    modulJadwalIbadah(
                        kategori: "ibadah_pelwap", title: "Ibadah Pelwap"),
                    modulJadwalIbadah(
                        kategori: "ibadah_pelprap", title: "Ibadah Pelprap"),
                  ],
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                ),
              ),
            )),
      ],
    );
  }
}
