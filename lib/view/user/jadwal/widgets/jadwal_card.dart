import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/user/jadwal/jadwal_detail.dart';
import 'package:sizer/sizer.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart'; // Import model

class JadwalCard extends StatelessWidget {
  final ModelJadwal jadwal;

  const JadwalCard({Key? key, required this.jadwal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color(0xFF006298),
              const Color.fromARGB(255, 116, 205, 219),
            ]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              bottomLeft: Radius.circular(7),
              bottomRight: Radius.circular(7),
              topRight: Radius.circular(48),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                offset: Offset(5, 5),
                color: const Color(0xFF006298).withOpacity(0.4),
              ),
              BoxShadow(
                blurRadius: 7,
                offset: Offset(-2, -2),
                color: const Color(0xFF006298).withOpacity(0.4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: SizedBox(
              height: 10.h, // Ubah tinggi menjadi sama dengan NoData
              child: Row(
                children: [
                  Container(
                    width: 88,
                    color: const Color(0xFF004D73),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          jadwal.tanggal2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${jadwal.hari}\n',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 241, 241, 241),
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                text: jadwal.jam,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SizedBox(width: 10),
                              Image.asset(
                                'assets/images/dots.png',
                                height: 5.h,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jadwal.lokasi,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 8, 10, 8),
                                      width: double.infinity,
                                      height: 0.5,
                                      color: Colors.grey[200],
                                    ),
                                    Text(
                                      jadwal.alamat,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Susunan\n',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Pelayan',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Data\n',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'PIC',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Get.toNamed(GetRoutes.jadwaldetail,
                    arguments: jadwalDetail(dataJadwal: jadwal));
              },
              splashColor: Colors.teal[200],
              splashFactory: InkSplash.splashFactory,
            ),
          ),
        ),
      ],
    );
  }
}
