import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/common/responsive.dart';
import 'package:gpdikpbaru/common/styles.dart';
import 'package:gpdikpbaru/controller/admin/data_contactperson_controller.dart';
import 'package:gpdikpbaru/widgets/topline_bottomsheet.dart';
import 'package:sizer/sizer.dart';

view_cp(data_contactperson) {
  final ContactPerson_Controller contactP_C = Get.find();
  Get.bottomSheet(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: 35.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  topline_bottomsheet(),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: CtrMainColor,
                          radius: 55.0,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage('${data_contactperson.urlGambar}'),
                            radius: 50.0,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(data_contactperson.nama, style: defaultFontBold),
                        Text(data_contactperson.ket, style: defaultFont),
                        Row(
                          children: [
                            Icon(Icons.house, size: Responsive.FONT_SIZE_LARGE),
                            Text(
                              "Alamat : ",
                              style: defaultFontMed.copyWith(
                                  fontSize: Responsive.FONT_SIZE_DEFAULT),
                            ),
                            Text(
                              data_contactperson.alamat,
                              style: defaultFont.copyWith(
                                  fontSize: Responsive.FONT_SIZE_DEFAULT),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.phone, size: Responsive.FONT_SIZE_LARGE),
                            Text(
                              "No HP : ",
                              style: defaultFontMed.copyWith(
                                  fontSize: Responsive.FONT_SIZE_DEFAULT),
                            ),
                            Text(
                              data_contactperson.noHp,
                              style: defaultFont.copyWith(
                                  fontSize: Responsive.FONT_SIZE_DEFAULT),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 8, 4, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                child: InkWell(
                                  onTap: () {
                                    contactP_C.OpenUrl(
                                        "tel:${data_contactperson.noHp}");
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 8, 0, 8),
                                    child: Icon(
                                      Icons.call,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                child: InkWell(
                                  onTap: () {
                                    contactP_C.OpenUrl(
                                        "https://web.whatsapp.com/send?phone=${data_contactperson.noHp}&text&app_absent=0");
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 8, 0, 8),
                                    child: Icon(
                                      Icons.message,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    ),
  );
}
