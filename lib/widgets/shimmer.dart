import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget {
  static Widget rectangular({
    required double? width,
    required double? height,
    Color? baseColor = shadowColor,
    Color? highlightColor = backgroundColor,
    double? borderRadius = 0,
    EdgeInsets? margin,
    EdgeInsets? padding,
    bool enabled = true,
  }) {
    return Shimmer.fromColors(
      enabled: enabled,
      baseColor: Get.theme.brightness == Brightness.dark
          ? Get.theme.colorScheme.background
          : Get.theme.shadowColor,
      highlightColor: Get.theme.brightness == Brightness.dark
          ? Get.theme.shadowColor
          : Get.theme.colorScheme.background,
      child: Container(
        margin: margin,
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Get.theme.shadowColor.withAlpha(150),
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
      ),
    );
  }

  static Widget card() {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Get.theme.brightness == Brightness.light
              ? Get.theme.shadowColor.withAlpha(50)
              : Get.theme.colorScheme.background.withAlpha(100),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget.rectangular(
                  width: 100,
                  height: 10.h,
                  borderRadius: 10.r,
                  baseColor: Get.theme.shadowColor.withAlpha(150),
                ),
                ShimmerWidget.rectangular(
                  width: 75,
                  height: 20.h,
                  borderRadius: 5.r,
                  baseColor: Get.theme.shadowColor.withAlpha(150),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget.rectangular(
                    width: 25,
                    height: 15.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                  ShimmerWidget.rectangular(
                    width: 25,
                    height: 15.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget.rectangular(
                    width: 100,
                    height: 10.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                  ShimmerWidget.rectangular(
                    width: 100,
                    height: 10.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget.rectangular(
                    width: 25,
                    height: 15.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                  ShimmerWidget.rectangular(
                    width: 25,
                    height: 15.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget.rectangular(
                    width: 100,
                    height: 10.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                  ShimmerWidget.rectangular(
                    width: 100,
                    height: 10.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget.rectangular(
                    width: 70,
                    height: 10.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                  ShimmerWidget.rectangular(
                    width: 50,
                    height: 10.h,
                    borderRadius: 10.r,
                    baseColor: Get.theme.shadowColor.withAlpha(150),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget Items1() {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Get.theme.brightness == Brightness.light
              ? Get.theme.shadowColor.withAlpha(50)
              : Get.theme.colorScheme.background.withAlpha(100),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: ShimmerWidget.rectangular(
                  width: 60.w,
                  height: 10.h,
                  borderRadius: 10.r,
                  baseColor: Get.theme.shadowColor.withAlpha(150),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: ShimmerWidget.rectangular(
                  width: 110.w,
                  height: 12.h,
                  borderRadius: 10.r,
                  baseColor: Get.theme.shadowColor.withAlpha(150),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: ShimmerWidget.rectangular(
                  width: 100.w,
                  height: 12.h,
                  borderRadius: 10.r,
                  baseColor: Get.theme.shadowColor.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget circular({
    required double? size,
    Color baseColor = Colors.grey,
    Color highlightColor = Colors.white,
    EdgeInsets? margin,
    EdgeInsets? padding,
    bool enabled = true,
  }) {
    return Shimmer.fromColors(
      enabled: enabled,
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        margin: margin,
        padding: padding,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Get.theme.shadowColor.withAlpha(150),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
