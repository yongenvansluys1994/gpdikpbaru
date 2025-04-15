import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Lottie.asset('assets/lottie/nodata.json', width: 40.w, repeat: false),
    );
  }
}
