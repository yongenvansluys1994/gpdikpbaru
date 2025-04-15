import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 260);
    path.quadraticBezierTo(size.width / 4, 300 /*180*/, size.width / 2, 300);
    path.quadraticBezierTo(3 / 4 * size.width, 300, size.width, 260);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipperMedium extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 200);
    path.quadraticBezierTo(size.width / 4, 212 /*200*/, size.width / 2, 212);
    path.quadraticBezierTo(3 / 4 * size.width, 212, size.width, 200);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipperSmall extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 105);
    path.quadraticBezierTo(size.width / 4, 105 /*180*/, size.width / 2, 105);
    path.quadraticBezierTo(3 / 4 * size.width, 105, size.width, 105);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
