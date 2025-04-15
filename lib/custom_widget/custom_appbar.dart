import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/common/responsive.dart';
import 'package:gpdikpbaru/common/styles.dart';
import 'package:day_night_switch/day_night_switch.dart';

import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool leading;
  CustomAppBar({required this.title, required this.leading});

  @override
  Widget build(BuildContext context) {
    themedark theme = Get.find();
    return AppBar(
      backgroundColor: CtrMainColor,
      elevation: 0,
      title: Text(title,
          style: defaultFont.copyWith(
            fontSize: Responsive.FONT_SIZE_EXTRA_LARGE,
          )),
      automaticallyImplyLeading: leading,
      centerTitle: true,
      actions: [
        SizedBox(
          width: 19.w,
          height: 10.h,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: FittedBox(
              fit: BoxFit.fill,
              child: ObxValue(
                (data) => DayNightSwitch(
                  value: theme.isLightTheme.value,
                  onChanged: (val) {
                    theme.isLightTheme.value = val;
                    Get.changeThemeMode(
                      theme.isLightTheme.value
                          ? ThemeMode.light
                          : ThemeMode.dark,
                    );
                    theme.saveThemeStatus();
                  },
                ),
                false.obs,
              ),
            ),
          ),
        ),
      ],
      // leading: isBackButtonExist
      //     ? IconButton(
      //         icon: Icon(Icons.arrow_back_ios),

      //       )
      //     : SizedBox(),

      // actions: menuWidget != null ? [menuWidget] : null,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
