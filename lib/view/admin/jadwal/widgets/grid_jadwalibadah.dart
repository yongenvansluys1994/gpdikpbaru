import 'package:flutter/material.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

Widget modulJadwalIbadah({required String kategori, required String title}) {
  return Container(
    width: 30.w,
    height: 15.h,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 2.0)
      ],
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.white,
    ),
    child: Material(
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          Get.toNamed(GetRoutes.jadwalinput, arguments: [kategori, title]);
        },
        splashColor: Color.fromARGB(255, 224, 253, 246),
        splashFactory: InkSplash.splashFactory,
        child: Container(
          padding:
              EdgeInsets.only(top: 2.w, bottom: 5.w, left: 5.w, right: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                "assets/images/modul.png",
                width: 20.w,
                height: 10.h,
              ),
              Text(
                '${title}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
