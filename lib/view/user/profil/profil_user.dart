import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/profil/p_iman_controller.dart';
import 'package:gpdikpbaru/controller/profil/profiluser_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/routes/routes.dart';

import 'package:sizer/sizer.dart';

class ProfilUser extends StatefulWidget {
  @override
  State<ProfilUser> createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Profil Saya",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: GetBuilder<ProfilUserPageController>(
        init: ProfilUserPageController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header with gradient background
                Container(
                  height: 21.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 133, 186, 219),
                        Color.fromARGB(255, 133, 219, 208),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          // Top navigation
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          ),

                          // Wave pattern
                          SizedBox(
                            height: 50,
                            child: CustomPaint(
                              size: Size(MediaQuery.of(context).size.width, 50),
                              painter: WavePainter(),
                            ),
                          ),

                          // Profile picture that extends below the header
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),

                // Negative margin to position profile picture and info
                Transform.translate(
                  offset: Offset(0, -60),
                  child: Column(
                    children: [
                      // Profile picture
                      Container(
                        width: 32.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF3B82F6),
                          border: Border.all(color: Colors.white, width: 4),
                          image: DecorationImage(
                            image: controller.fotoprofil != ""
                                ? NetworkImage('${controller.fotoprofil}')
                                    as ImageProvider
                                : AssetImage('assets/images/icon-user.png')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // Profile name and location
                      Text(
                        '${controller.name}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: 16.w,
                          height: 7.h,
                          child: controller.lencana == ""
                              ? Image.asset("assets/badge/2.png")
                              : Image.asset(
                                  "assets/badge/${controller.lencana}")),

                      SizedBox(height: 20),

                      // Activity card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.h),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Main activity card
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Activities title with total distance
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ActivityStat(
                                            controller: controller,
                                            icon: Icons.thumb_up_outlined,
                                            value: '${controller.likes}',
                                            unit: ' likes',
                                            label: 'Jumlah Suka',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 25),

                                  // Activity stats row 1
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Jumlah Koleksi Lencana",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          controller.badges.isEmpty
                                              ? Center(
                                                  child: Text(
                                                      'No badges available'),
                                                )
                                              : SizedBox(
                                                  width: 75.w, // Lebar layar
                                                  height:
                                                      100, // Tinggi untuk item horizontal
                                                  child: ListView.builder(
                                                    scrollDirection: Axis
                                                        .horizontal, // Scroll horizontal
                                                    itemCount: controller
                                                        .badges.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final badge = controller
                                                          .badges[index];
                                                      return Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                                8.0), // Jarak antar item
                                                        child: Column(
                                                          children: [
                                                            Image.asset(
                                                              badge[
                                                                  'badge']!, // Menampilkan gambar badge
                                                              width: 13
                                                                  .w, // Lebar gambar
                                                              height: 9
                                                                  .h, // Tinggi gambar
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              badge[
                                                                  'name']!, // Menampilkan nama badge
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // "No goal" circle
                            Positioned(
                              right: -10,
                              top: -30,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 133, 186, 219),
                                      Color.fromARGB(255, 133, 219, 208),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${double.parse(controller.sumpoin.toStringAsFixed(3))}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Poin Iman',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Custom widget for activity stats with icon
class ActivityStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;
  final String label;
  final ProfilUserPageController controller;

  ActivityStat({
    Key? key,
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            controller.incrementLikes(
                controller.username); // Kirim username ke fungsi
          },
          icon: Icon(Icons.thumb_up_outlined),
          label: Text("Like"),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: unit,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Custom widget for activity stats without icon
class ActivityValueOnly extends StatelessWidget {
  final String value;
  final String label;

  ActivityValueOnly({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// Custom painter for wave pattern in header
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();

    // Draw wave pattern
    path.moveTo(0, size.height * 0.5);

    // First wave
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.25,
        size.width * 0.5, size.height * 0.5);

    // Second wave
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.75, size.width, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
