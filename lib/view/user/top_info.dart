import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gpdikpbaru/routes/routes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

Widget TopProfil(data_C) {
  return Obx(
    () {
      if (data_C.isFailed) {
        return Center(child: Text('Fetching data failed.'));
      }
      if (data_C.isEmpty) {
        return Center(child: Text('No data.'));
      }
      if (data_C.isLoading) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                width: 70.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/images/profil-user.png",
                            height: 3.7.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 3.7.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                        )
                      ],
                    ),
                  ],
                )),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            width: 70.w,
            height: 5.8.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFF39D2C0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Obx(
                              () => data_C.fotoprofil != ""
                                  ? Image.network(
                                      '${data_C.fotoprofil}',
                                      height: 3.4.h,
                                      width: 3.4.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/profil-user.png",
                                      height: 3.7.h,
                                      fit: BoxFit.cover,
                                    ),
                            )),
                      ),
                    ),
                    Obx(() => Container(
                        height: 3.5.h,
                        child: data_C.lencana == ""
                            ? Image.asset("assets/badge/2.png")
                            : Image.asset("assets/badge/${data_C.lencana}"))),
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                              "${data_C.items[0].nama == null ? "Tamu" : data_C.items[0].nama}"),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 19.w,
                      height: 4.h, // <-- Your width// <-- Your height
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, size: 15),
                            Text('Profil'),
                          ],
                        ),
                        style: TextButton.styleFrom(
                          primary: Color.fromARGB(255, 22, 187, 167),
                          side: BorderSide(
                              color: Color.fromARGB(255, 22, 187, 167),
                              width: 0.7),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        onPressed: () {
                          Get.toNamed(GetRoutes.myprofil);
                        },
                      ),
                    )
                  ],
                ),
              ],
            )),
      );
    },
  );
}
