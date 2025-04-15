import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/common/constants.dart';

import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:sizer/sizer.dart';

import '../routes/routes.dart';

// ignore: must_be_immutable
class MainDrawer extends StatelessWidget {
  home_controller2 session_C = Get.find();
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = session_C.items[0];
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(user.nama.toString()),
                    accountEmail: Text(user.username.toString()),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                          child: Obx(
                        () => session_C.fotoprofil != ""
                            ? Image.network(
                                '${session_C.fotoprofil}',
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/profil-user.png",
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                      )),
                    ),
                    decoration: BoxDecoration(color: CtrMainColor),
                  ),
                  ListTile(
                    title: Text('Home'),
                    tileColor: Get.currentRoute == GetRoutes.home
                        ? Colors.grey[300]
                        : null,
                    onTap: () {
                      print(Get.currentRoute);

                      Get.offNamed(GetRoutes.home);
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profil Saya'),
                    onTap: () {
                      Get.toNamed(GetRoutes.myprofil);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.local_police_outlined),
                    title: Text('Perjalanan Iman'),
                    onTap: () {
                      Get.toNamed(GetRoutes.perjalanan_iman);
                    },
                  ),
                  Divider(), //here is a divider
                  Text("Konten", style: TextStyle(color: Colors.grey)),
                  if (user.level == "admin") ...[
                    ListTile(
                        leading: Icon(Icons.live_tv),
                        title: Text('Input Live Streaming'),
                        onTap: () {
                          Get.toNamed(GetRoutes.live);
                        }),
                    ListTile(
                        leading: Icon(Icons.post_add_sharp),
                        title: Text('Input Renungan Harian'),
                        onTap: () {
                          Get.toNamed(GetRoutes.renunganharian);
                        }),
                    ListTile(
                        leading: Icon(Icons.post_add_sharp),
                        title: Text('Input Pengumuman'),
                        onTap: () {
                          Get.toNamed(GetRoutes.berita);
                        }),
                    ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text('Kolekte Online'),
                        onTap: () {
                          Get.toNamed(GetRoutes.kolekte);
                        }),
                    ListTile(
                        leading: Icon(Icons.radio),
                        title: Text('Radio Online'),
                        onTap: () {
                          Get.toNamed(GetRoutes.radioadmin);
                        }),
                    ListTile(
                        leading: Icon(Icons.message_sharp),
                        title: Text('Pemberitahuan Berjalan'),
                        onTap: () {
                          Get.toNamed(GetRoutes.alert_beranda);
                        }),
                    ListTile(
                        leading: Icon(Icons.notifications_active_sharp),
                        title: Text('Broadcast Notifikasi'),
                        onTap: () {
                          Get.toNamed(GetRoutes.broadcast, arguments: {
                            'username': user.username,
                          });
                        }),
                    Divider(), //here is a divider
                    Text("Data Master", style: TextStyle(color: Colors.grey)),
                    ListTile(
                        leading: Icon(Icons.post_add_sharp),
                        title: Text('Daftar Bank Kolekte'),
                        onTap: () {
                          Get.toNamed(GetRoutes.daftarbank);
                        }),
                    ListTile(
                        leading: Icon(Icons.contact_phone),
                        title: Text('Daftar Contact Person'),
                        onTap: () {
                          Get.toNamed(GetRoutes.contactperson);
                        }),
                  ],
                  if (user.level == "user") ...[
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('Contact Person'),
                      onTap: () {
                        Get.toNamed(GetRoutes.contact_person);
                      },
                    ),
                  ],

                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      session_C.logout();
                    },
                  ),
                  Container(
                      color: Colors.grey[300],
                      height: 4.h,
                      width: 100.h,
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          'App Version - 1.${ApiAuth.APP_VERSION}',
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
