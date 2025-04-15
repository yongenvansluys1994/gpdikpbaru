import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import 'package:gpdikpbaru/controller/admin/data_berita_controller.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/view/admin/berita/berita_item.dart';

import 'package:gpdikpbaru/view/admin/berita/widgets/bottomsheet.dart';
import 'package:gpdikpbaru/widgets/dismiss_keyboard.dart';
import 'package:gpdikpbaru/widgets/loading_more.dart';
import 'package:gpdikpbaru/widgets/nodata.dart';
import 'package:gpdikpbaru/widgets/shimmer/shimmer_list.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:sizer/sizer.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';

// ignore: must_be_immutable
class beritaAdmin extends StatelessWidget {
  var selectedfABLocation = FloatingActionButtonLocation.endDocked;
  final home_controller2 session_C = Get.find();
  final Berita_Controller controller = Get.put(Berita_Controller());

  beritaAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Berita Terkini", leading: true),
          body: RefreshIndicator(
            onRefresh: controller.refresh,
            child: GestureDetector(
              onTap: () {
                dismissKeyboard();
              },
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () {
                        if (controller.isFailed) {
                          return ShimmerList();
                        }

                        if (controller.isEmpty) {
                          return NoData(); //menampilkan lotties no data
                        }

                        if (controller.isLoadingFirst) {
                          return ShimmerList();
                        }

                        return ScrollablePositionedList.builder(
                          itemScrollController: controller.itemScrollController,
                          itemPositionsListener:
                              controller.itemPositionsListener,
                          itemCount: controller.count + 1,
                          itemBuilder: (_, index) {
                            bool isItem = index < controller.count;
                            bool isLastIndex = index == controller.count;
                            bool isLoadingMore =
                                isLastIndex && controller.isLoadingMore;

                            // User Item
                            if (isItem)
                              return BeritaItem(controller.item(index));
                            // Show loading more at the bottom
                            if (isLoadingMore) return LoadingMore();
                            // Default empty content
                            return Container();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
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
            onPress: () {
              tambahberita_bottom(aksi: "input", Id: "", context: context);
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
                      "Klik Tombol + untuk Menambah Data",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 239, 239, 239)),
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  displayDeleteDialog(String docId) {
    Get.defaultDialog(
      title: "Delete Employee",
      titleStyle: TextStyle(fontSize: 20),
      middleText: 'Are you sure to delete employee ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.black,
      onCancel: () {},
      onConfirm: () {
        // controller.deleteData(docId);
      },
    );
  }
}
