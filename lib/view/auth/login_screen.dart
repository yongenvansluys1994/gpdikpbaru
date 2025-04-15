import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';

import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/controller/login_controller.dart';
import 'package:gpdikpbaru/widgets/dismiss_keyboard.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final loginC = Get.put(LoginController());

  final formKey = GlobalKey<FormState>();

  var isPasswordVisible = true.obs;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: GetBuilder<LoginController>(builder: (controller) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context)
                      .size
                      .height, // Minimal setinggi layar
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: Get.height / 2,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          color: Color(0XFFf1f5fb),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: Get.height * 0.04),
                            CarouselSlider.builder(
                              itemCount: controller.carouselCount,
                              itemBuilder: (context, index, realIndex) {
                                if (index == 0) {
                                  return controller.buildCarousel();
                                } else if (index == 1) {
                                  return controller.buildCarousel();
                                } else if (index == 2) {
                                  return controller.buildCarousel();
                                } else {
                                  return controller.buildCarousel();
                                }
                              },
                              options: CarouselOptions(
                                height: Get.height * 0.43,
                                scrollDirection: Axis.horizontal,
                                scrollPhysics: const ClampingScrollPhysics(),
                                enableInfiniteScroll: false,
                                autoPlayInterval: const Duration(seconds: 10),
                                viewportFraction: 1,
                                initialPage: 0,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) => controller
                                    .changeCarouselIndicator(index, reason),
                              ),
                              carouselController: controller.carouselController,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  controller.carouselCount,
                                  (index) {
                                    controller.isActive =
                                        index == controller.activeIndex;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: controller.isActive
                                              ? const Color(0XFF006298)
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: const Color(0XFF006298),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            dismissKeyboard();
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.sp),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 79, 202, 255),
                                  Color.fromARGB(255, 189, 255, 227),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: kPrimaryLightColor,
                                    borderRadius: BorderRadius.circular(29),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 4,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: controller.nikController,
                                    cursorColor: textLink,
                                    keyboardType: TextInputType
                                        .number, // Hanya menampilkan keyboard angka
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Hanya angka yang diperbolehkan
                                    ],
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.call, color: textLink),
                                      hintText: "Masukkan No HP Anda",
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "No HP harus diisi";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Obx(() => Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: kPrimaryLightColor,
                                        borderRadius: BorderRadius.circular(29),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 4,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller:
                                            controller.passwordController,
                                        obscureText: isPasswordVisible.value,
                                        cursorColor: kPrimaryColor,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          icon:
                                              Icon(Icons.lock, color: textLink),
                                          suffixIcon: GestureDetector(
                                            onTap: () =>
                                                isPasswordVisible.value =
                                                    !isPasswordVisible.value,
                                            child: Icon(
                                              isPasswordVisible.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.black54,
                                              size: 22,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 20),
                                CupertinoButton.filled(
                                  child: Text("Login"),
                                  onPressed: () => controller.CheckLogin(),
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () => Get.toNamed(GetRoutes.register),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Belum punya Akun? ",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 9, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .amber, // Warna latar belakang badge
                                          borderRadius: BorderRadius.circular(
                                              3.sp), // Radius sudut badge
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                  0.2), // Warna bayangan
                                              blurRadius:
                                                  4, // Radius blur bayangan
                                              offset: Offset(
                                                  0, 2), // Posisi bayangan
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          "Daftar Disini",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black, // Warna teks
                                          ),
                                        ),
                                      ),
                                    ],
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
              ),
            );
          }),
        ),
      ],
    );
  }
}
