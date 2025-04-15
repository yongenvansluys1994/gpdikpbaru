import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/profil/p_iman_controller.dart';
import 'package:gpdikpbaru/widgets/topline_bottomsheet.dart';

import 'package:sizer/sizer.dart';

view_lencana(
    {required poin_task,
    required nm_task,
    required String lencana,
    required String teks,
    required home_controller2 sessionC,
    required p_iman_controller p_imanC}) {
  Get.bottomSheet(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: // Generated code for this Card_Task_3 Widget...
                Padding(
              padding: EdgeInsetsDirectional.fromSTEB(6, 6, 6, 6),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topline_bottomsheet(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/badge/${lencana}",
                        width: 14.w,
                        height: 7.6.h,
                        fit: BoxFit.contain,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 8, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${nm_task}',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF14181B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: SelectionArea(
                                    child: Text(
                                  '${poin_task == "1" ? "${poin_task}000" : "${poin_task}"} points',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      lencana == sessionC.lencana
                          ? Row(
                              children: [
                                Text(
                                  'Dipakai',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color.fromARGB(255, 232, 197, 0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Color.fromARGB(255, 232, 197, 0),
                                  size: 24,
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Text(
                      '${teks}',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      double.tryParse(poin_task)! >= 0.999
                          ? SizedBox(
                              width: 90.w, // <-- Your width
                              height: 4.h, // <-- Your height
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(150, 43),
                                    primary: MainColor,
                                    onPrimary: Colors.white,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    p_imanC.edit_lencana(
                                        id_user: sessionC.items[0].idUser,
                                        username: sessionC.items[0].username,
                                        lencana: lencana);
                                  },
                                  child: Text(
                                    "Pakai Lencana",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.sp),
                                  )),
                            )
                          : SizedBox(
                              width: 90.w, // <-- Your width
                              height: 4.h, // <-- Your height
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(150, 43),
                                    primary: Colors.grey,
                                    onPrimary: Colors.white,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Pakai Lencana",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.sp),
                                  )),
                            )
                    ],
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
