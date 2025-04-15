import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

Widget ShimmerList() {
  return ListView(
    children: List.generate(
      10,
      (index) => Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.2),
        highlightColor: Colors.white,
        child: Card(
          child: Container(
            height: 12.h,
          ),
        ),
      ),
    ),
  );
}
