import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/profil/editprofil_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';

import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class editProfil extends StatelessWidget {
  home_controller2 session_C = Get.find();

  editprofil_controller controller_tes = Get.find();

  @override
  Widget build(BuildContext context) {
    final user = session_C.items[0];
    return Scaffold(
      appBar: CustomAppBar(title: ApiAuth.APP_NAME, leading: true),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<editprofil_controller>(
                // specify type as Controller
                init: editprofil_controller(), // intialize with the Controller
                builder: (value) => Container(
                    width: 47.w,
                    height: 22.h,
                    child: (controller_tes.image == null)
                        ? Image.asset(
                            "assets/images/default-img.png",
                            width: 47.w,
                            height: 22.h,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(controller_tes.pathImage),
                            width: 47.w,
                            height: 22.h,
                            fit: BoxFit.cover,
                          )),
              )
            ],
          ),
          Positioned(
            right: 3,
            child: SizedBox(
              width: 30.w,
              child: ElevatedButton(
                onPressed: () {
                  controller_tes.openCameraGereja();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(MainColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.camera_alt, size: 20),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Ganti Foto',
                      style: TextStyle(fontSize: 9.sp),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 65.h,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.5.h),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 6.h,
                              child: Material(
                                elevation: 20.0,
                                shadowColor: Colors.grey[200],
                                child: TextFormField(
                                  autofocus: false,
                                  controller: controller_tes.namaCon,
                                  decoration: InputDecoration(
                                    labelText: 'Nama',
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                  ),
                                  onChanged: (value) {},
                                ),
                              )),
                          SizedBox(height: 0.5.h),
                          Container(
                              height: 6.h,
                              child: Material(
                                elevation: 20.0,
                                shadowColor: Colors.grey[200],
                                child: TextFormField(
                                  autofocus: false,
                                  controller: controller_tes.notelpCon,
                                  decoration: InputDecoration(
                                    labelText: 'No. Telepon',
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                  ),
                                  onChanged: (value) {},
                                ),
                              )),
                          SizedBox(height: 0.5.h),
                          Container(
                              height: 6.h,
                              child: Material(
                                elevation: 20.0,
                                shadowColor: Colors.grey[200],
                                child: TextFormField(
                                  autofocus: false,
                                  controller: controller_tes.tglCon,
                                  decoration: InputDecoration(
                                    labelText: 'Tanggal Lahir',
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                  ),
                                  onChanged: (value) {},
                                ),
                              )),
                          SizedBox(height: 0.5.h),
                          Container(
                              child: Material(
                            elevation: 20.0,
                            shadowColor: Colors.grey[200],
                            child: TextFormField(
                              autofocus: false,
                              controller: controller_tes.alamatCon,
                              minLines:
                                  3, // any number you need (It works as the rows for the textarea)
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: 'Alamat',
                                labelStyle: TextStyle(
                                  fontSize: 15.sp,
                                ),
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              ),
                              onChanged: (value) {},
                            ),
                          )),
                          SizedBox(height: 0.5.h),
                          Container(
                              child: Material(
                            elevation: 20.0,
                            shadowColor: Colors.grey[200],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Jenis Kelamin",
                                    style: TextStyle(
                                      fontSize: 12.5.sp,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 17),
                                  child: Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                // color: _valuegender == 0
                                                //     ? Color.fromARGB(
                                                //         255, 152, 205, 240)
                                                //     : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            height: 5.h,
                                            width: 10.w,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Image.asset(
                                                "assets/images/male.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                // color: _valuegender == 1
                                                //     ? Color.fromARGB(
                                                //         255, 152, 205, 240)
                                                //     : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            height: 5.h,
                                            width: 10.w,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Image.asset(
                                                "assets/images/female.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                          SizedBox(height: 0.5.h),
                          Container(
                              height: 6.h,
                              child: Material(
                                elevation: 20.0,
                                shadowColor: Colors.grey[200],
                                child: TextFormField(
                                  autofocus: false,
                                  controller: controller_tes.emailCon,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                  ),
                                  onChanged: (value) {},
                                ),
                              )),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 85.w, // <-- Your width
                                height: 35, // <-- Your height
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(150, 43),
                                      primary: MainColor,
                                      onPrimary: Colors.white,
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller_tes.CheckSimpan(
                                          id_user: user.idUser,
                                          username: user.username);
                                    },
                                    child: Text(
                                      "Simpan",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.sp),
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
