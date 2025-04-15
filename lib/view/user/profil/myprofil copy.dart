import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/routes/routes.dart';

import 'package:sizer/sizer.dart';

class MyProfil extends StatefulWidget {
  @override
  State<MyProfil> createState() => _MyProfilState();
}

class _MyProfilState extends State<MyProfil> {
  home_controller2 session_C = Get.find();
  @override
  Widget build(BuildContext context) {
    final user = session_C.items[0];
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Profil Saya", leading: true),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Obx(
                  () => session_C.fotoprofil != ""
                      ? CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                NetworkImage('${session_C.fotoprofil}'),
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      : CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                AssetImage('assets/images/icon-user.png'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${user.nama}',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => Container(
                    width: 16.w,
                    height: 7.h,
                    child: session_C.lencana == ""
                        ? Image.asset("assets/badge/2.png")
                        : Image.asset("assets/badge/${session_C.lencana}"))),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Card(
                          margin: EdgeInsets.symmetric(vertical: 1),
                          child: InkWell(
                            child: ListTile(
                                title: Text('Edit Profil'),
                                dense: true,
                                visualDensity: VisualDensity(vertical: -1),
                                trailing: Icon(Icons.arrow_forward_ios)),
                            onTap: () {
                              Get.toNamed(GetRoutes.editprofil);
                            },
                          )),
                      Card(
                          margin: EdgeInsets.symmetric(vertical: 1),
                          child: InkWell(
                            child: ListTile(
                                title: Text('Ganti Password'),
                                dense: true,
                                visualDensity: VisualDensity(vertical: -1),
                                trailing: Icon(Icons.arrow_forward_ios)),
                            onTap: () {},
                          )),
                      SizedBox(height: 2.h),
                      GestureDetector(
                        child: Card(
                            margin: EdgeInsets.symmetric(vertical: 1),
                            child: ListTile(
                                title: Text('Perjalanan Iman'),
                                dense: true,
                                visualDensity: VisualDensity(vertical: -1),
                                trailing: Icon(Icons.arrow_forward_ios))),
                        onTap: () {
                          Get.toNamed(GetRoutes.perjalanan_iman);
                        },
                      ),
                      Card(
                          margin: EdgeInsets.symmetric(vertical: 1),
                          child: ListTile(
                              title: Text('Hubungi Kami'),
                              dense: true,
                              visualDensity: VisualDensity(vertical: -1),
                              trailing: Icon(Icons.arrow_forward_ios))),
                      Card(
                          margin: EdgeInsets.symmetric(vertical: 1),
                          child: ListTile(
                              title: Text('Tentang Aplikasi'),
                              dense: true,
                              visualDensity: VisualDensity(vertical: -1),
                              trailing: Icon(Icons.arrow_forward_ios))),
                      GestureDetector(
                        onTap: () async {
                          await session_C.FetchlaunchUrl();
                        },
                        child: Card(
                            margin: EdgeInsets.symmetric(vertical: 1),
                            child: ListTile(
                                title: Text('Hapus Akun'),
                                dense: true,
                                visualDensity: VisualDensity(vertical: -1),
                                trailing: Icon(Icons.arrow_forward_ios))),
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: 85.w, // <-- Your width
                        height: 40, // <-- Your height
                        child: TextButton(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text('Logout',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                          style: TextButton.styleFrom(
                            primary: Colors.teal,
                            onSurface: Colors.yellow,
                            side: BorderSide(color: Colors.teal, width: 1),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                          ),
                          onPressed: () {
                            session_C.logout();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
