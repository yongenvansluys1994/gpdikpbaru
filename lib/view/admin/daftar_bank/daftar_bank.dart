import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/admin/bank_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/view/admin/daftar_bank/widgets/bottomsheet.dart';
import 'package:gpdikpbaru/view/admin/daftar_bank/widgets/bottomsheet_edit.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class daftarBankAdmin extends StatefulWidget {
  daftarBankAdmin({super.key});

  @override
  State<daftarBankAdmin> createState() => _daftarBankAdminState();
}

class _daftarBankAdminState extends State<daftarBankAdmin> {
  final home_controller2 session_C = Get.find();
  final Bank_Controller bank_C = Get.find();

  var selectedfABLocation = FloatingActionButtonLocation.endDocked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Daftar Bank", leading: true),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => ListView.builder(
                      itemCount: bank_C.data_bank.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data_bank = bank_C.data_bank[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      // flex: 2,
                                      onPressed: (context) {
                                        bank_C.namabankController.text =
                                            data_bank['nama_bank'];
                                        bank_C.norekController.text =
                                            data_bank['no_rek'];
                                        bank_C.namarekController.text =
                                            data_bank['nama_rek'];
                                        bank_C.carabayarController.text =
                                            data_bank["cara_bayar"];
                                        editbank_bottom(
                                            aksi: "edit",
                                            postID: data_bank["postID"],
                                            image: data_bank["image"]);
                                      },
                                      backgroundColor:
                                          Color.fromARGB(255, 67, 67, 67),
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        bank_C.delete(
                                            postID: data_bank["postID"]);
                                      },
                                      backgroundColor:
                                          Color.fromARGB(255, 115, 149, 196),
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  child: SizedBox(
                                    height: 9.5.h,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 16.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${data_bank['image']}"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: double.infinity,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Stack(children: [
                                                  Container(
                                                    width: 55.w,
                                                    margin: EdgeInsets.only(
                                                        left: 15, top: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${data_bank['nama_bank']}"),
                                                        SizedBox(height: 0.3.h),
                                                        Text(
                                                          "Nama Rek : ${data_bank['nama_rek']}",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      105,
                                                                      105,
                                                                      105),
                                                              fontSize: 8.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.maxFinite,
                                                    margin: EdgeInsets.only(
                                                        right: 8, top: 5),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: badges.Badge(
                                                          badgeStyle:
                                                              badges.BadgeStyle(
                                                            shape: badges
                                                                .BadgeShape
                                                                .square,
                                                            badgeColor:
                                                                badge_success,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          badgeContent: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: Text(
                                                              'Aktif',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      7.sp),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  Container(
                                                    height: 7.h,
                                                    margin: EdgeInsets.only(
                                                      left: 2,
                                                      top: 8,
                                                      right: 3,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 16.sp,
                                                        color: lightBlueColor,
                                                      ),
                                                    ),
                                                  ),
                                                ])
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: selectedfABLocation,
          floatingActionButton: SpeedDial(
            backgroundColor: Colors.teal[200],
            icon: Icons.add,
            activeIcon: Icons.close,
            spacing: 3,
            childPadding: const EdgeInsets.all(5),
            spaceBetweenChildren: 4,
            onOpen: () {
              tambahbank_bottom(aksi: "input", postID: "", context: context);
            },
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.teal[200],
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 6.h,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Text(
                      "Klik Tombol + untuk Mengisi Kolekte",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 239, 239, 239)),
                    ),
                  )),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
