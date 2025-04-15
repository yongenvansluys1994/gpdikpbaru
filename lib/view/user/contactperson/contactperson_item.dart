import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/common/responsive.dart';
import 'package:gpdikpbaru/common/styles.dart';
import 'package:gpdikpbaru/controller/admin/inputcontactperson_controller.dart';
import 'package:gpdikpbaru/models/model_contactperson.dart';
import 'package:gpdikpbaru/view/user/contactperson/widgets/bottomsheet.dart';

import 'package:sizer/sizer.dart';

class ContactPersonItem extends StatelessWidget {
  final ModelContactPerson user;
  final inputContactPersonController controller =
      Get.put(inputContactPersonController());
  ContactPersonItem(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          width: 30.w,
          height: 16.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 1), blurRadius: 2.0)
            ],
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                view_cp(user);
              },
              splashColor: Color.fromARGB(255, 224, 253, 246),
              splashFactory: InkSplash.splashFactory,
              child: Container(
                padding: EdgeInsets.only(
                    top: 1.w, bottom: 1.w, left: 1.w, right: 1.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: CtrMainColor,
                      radius: 15.w,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${user.urlGambar}"),
                        radius: 14.w,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            '${user.nama}',
                            style: defaultFontBold.copyWith(
                                fontSize: Responsive.FONT_SIZE_DEFAULT),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${user.ket}',
                            style: defaultFont.copyWith(
                                fontSize: Responsive.FONT_SIZE_DEFAULT),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
