import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/register_controller.dart';
import 'package:gpdikpbaru/widgets/dismiss_keyboard.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  final registerC = Get.put(RegisterController());

  final formKey = GlobalKey<FormState>();

  var isPasswordVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pendaftaran Akun"),
      ),
      body: GestureDetector(
        onTap: () {
          dismissKeyboard();
        },
        child: Form(
          key: formKey,
          child: GetBuilder<RegisterController>(builder: (controller) {
            return Container(
              width: double.infinity,
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 17.h),
                    Text(
                      "Daftar Akun",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23.sp,
                          color: MainColor),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        controller: controller.R_namaController,
                        cursorColor: textLink,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: textLink,
                          ),
                          hintText: "Masukkan Nama Lengkap Anda",
                          border: InputBorder.none,
                        ),
                        validator: (nik) {
                          if (nik == null || nik.isEmpty) {
                            return "No HP harus diisi";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        controller: controller.R_tanggalController,
                        cursorColor: textLink,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.date_range,
                            color: textLink,
                          ),
                          hintText: "Masukkan Tanggal Lahir Anda",
                          border: InputBorder.none,
                        ),
                        validator: (nik) {
                          if (nik == null || nik.isEmpty) {
                            return "Tanggal Lahir harus diisi";
                          } else {
                            return null;
                          }
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2015 - 01 - 01),
                              firstDate: DateTime(
                                  1890), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2015));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            registerC.changevaluetanggal(
                                formattedDate: formattedDate);
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        controller: controller.R_nikController,
                        cursorColor: textLink,
                        keyboardType: TextInputType
                            .number, // Hanya menampilkan keyboard angka
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // Hanya angka yang diperbolehkan
                        ],
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.call,
                            color: textLink,
                          ),
                          hintText: "Masukkan No HP Anda",
                          border: InputBorder.none,
                        ),
                        validator: (nik) {
                          if (nik == null || nik.isEmpty) {
                            return "NIK/No HP harus diisi";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Obx(() => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            controller: controller.R_passwordController,
                            obscureText: isPasswordVisible.value,
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Buat Password",
                              icon: Icon(
                                Icons.lock,
                                color: textLink,
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                  minWidth: 45, maxWidth: 46),
                              suffixIcon: Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    isPasswordVisible.value =
                                        !isPasswordVisible.value;
                                  },
                                  child: Icon(
                                    isPasswordVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black54,
                                    size: 22,
                                  ),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return "Password harus diisi";
                              } else {
                                return null;
                              }
                            },
                          ),
                        )),
                    SizedBox(height: 1.h),
                    CupertinoButton.filled(
                        child: Text(
                          "Daftar",
                        ),
                        onPressed: () {
                          controller.CheckRegister();
                        }),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sudah punya Akun? ",
                            style: TextStyle(
                              fontSize: 17,
                              color: lightTextColor,
                            ),
                          ),
                          Text(
                            "Login Disini",
                            style: TextStyle(
                                fontSize: 17,
                                color: lightTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
