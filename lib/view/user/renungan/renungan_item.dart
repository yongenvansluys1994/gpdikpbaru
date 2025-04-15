import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/models/model_datarenungan.dart';
import 'package:gpdikpbaru/routes/routes.dart';

import 'package:gpdikpbaru/view/user/renungan/renungan_detail.dart';
import 'package:sizer/sizer.dart';

class RenunganItem extends StatefulWidget {
  final ModeldataRenungan user;

  RenunganItem(this.user, {Key? key}) : super(key: key);

  @override
  State<RenunganItem> createState() => _RenunganItemState();
}

class _RenunganItemState extends State<RenunganItem> {
  final themedark theme = Get.find();
  int comments = 0;
  int likes = 0;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    onCall(id: int.parse(widget.user.idRenungan));
    //mengirim value ID terlebih dahulu
  }

  void onCall({required int id}) async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('likes')
        .where("id", whereIn: [id])
        .where("parent", isEqualTo: "renungan")
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    setState(() {
      likes = _myDocCount.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromARGB(255, 210, 210, 210).withOpacity(0.6),
            offset: const Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.isLightTheme.value ? CtrWhite : CtrWhite2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                child: Stack(
                  alignment: AlignmentDirectional(0, 1),
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, -1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.network(
                          "${widget.user.urlGambar}",
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: Color(0xFF39D2C0),
                                  size: 24,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 0),
                                  child: Text(
                                    'Admin',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF39D2C0),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF4B39EF),
                                      Color(0xFF39D2C0),
                                      Color(0xFFE0E3E7)
                                    ],
                                    stops: [0, 0.3, 1],
                                    begin: AlignmentDirectional(1, 0.98),
                                    end: AlignmentDirectional(-1, -0.98),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2, 2, 2, 2),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.chevron_right_rounded,
                                      color: Color(0xFF14181B),
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(GetRoutes.renungandetail,
                                arguments: RenunganDetail(detail: widget.user));
                          },
                          splashColor: Colors.teal[200],
                          splashFactory: InkSplash.splashFactory,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 2, 0, 0),
                child: Text(
                  '${widget.user.judulRenungan}',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Color(0xFF14181B),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Text(
                  '${widget.user.isiRenungan}..',
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 2),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     children: [
              //       Text(
              //         '${likes} teman menyukai postingan ini',
              //         style: TextStyle(
              //           fontFamily: 'Plus Jakarta Sans',
              //           color: Color(0xFF57636C),
              //           fontSize: 14,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
