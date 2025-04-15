import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:gpdikpbaru/controller/admin/data_live_controller.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';

import 'package:gpdikpbaru/view/user/live/live_item.dart';
import 'package:gpdikpbaru/widgets/loading_more.dart';
import 'package:gpdikpbaru/widgets/nodata.dart';
import 'package:gpdikpbaru/widgets/shimmer/shimmer_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class livePage extends StatelessWidget {
  final home_controller2 session_C = Get.find();
  final Live_Controller controller = Get.find();

  livePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: false,
          appBar: CustomAppBar(title: "Live Streaming", leading: true),
          body: RefreshIndicator(
            onRefresh: controller.refresh,
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
                        itemPositionsListener: controller.itemPositionsListener,
                        itemCount: controller.count + 1,
                        itemBuilder: (_, index) {
                          bool isItem = index < controller.count;
                          bool isLastIndex = index == controller.count;
                          bool isLoadingMore =
                              isLastIndex && controller.isLoadingMore;

                          // User Item
                          if (isItem) return LiveItem(controller.item(index));
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
