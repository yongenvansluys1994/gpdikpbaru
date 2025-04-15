import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool leading;
  CustomAppBar(
      {required this.title, required this.leading, required bool isLogin});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: MainColor),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      // flexibleSpace: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: <Color>[Color.fromARGB(255, 23, 48, 187), Colors.cyan],
      //     ),
      //   ),
      // ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.006, horizontal: Get.width * 0.015),
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: lightTextColor,
              border: Border.all(
                width: 2.w,
              ),
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications,
                color: lightBlueColor2,
              ),
              tooltip: "Open notifications menu",
              onPressed: () {},
            ),
          ),
        ),
      ],
      leading: leading == true
          ? Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.006, horizontal: Get.width * 0.009),
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: lightTextColor,
                  border: Border.all(
                    width: 2.w,
                  ),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: lightBlueColor2,
                  ),
                  tooltip: "Open notifications menu",
                  onPressed: () {
                    Get.back();
                    //Get.offNamed(Routes.DASHBOARD);
                  },
                ),
              ),
            )
          : SizedBox(),

      // actions: menuWidget != null ? [menuWidget] : null,
    );
  }

  @override
  Size get preferredSize => Size(1170.w, GetPlatform.isDesktop ? 70.h : 50.h);
}
