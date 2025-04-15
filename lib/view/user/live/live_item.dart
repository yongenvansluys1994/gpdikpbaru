import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/models/model_datalive.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/user/live/live_detail.dart';

import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class LiveItem extends StatefulWidget {
  final ModeldataLive user;

  LiveItem(this.user, {Key? key}) : super(key: key);

  @override
  State<LiveItem> createState() => _LiveItemState();
}

class _LiveItemState extends State<LiveItem> {
  int comments = 0;
  int likes = 0;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    onCall(id: int.parse(widget.user.idLive));
    //mengirim value ID terlebih dahulu
  }

  void onCall({required int id}) async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('comments')
        .where("id", whereIn: [id])
        .where("parent", isEqualTo: "live")
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    setState(() {
      comments = _myDocCount.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.network(
              'https://img.youtube.com/vi/${widget.user.urlLive}/0.jpg',
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/default-img.png");
              },
              width: 100.w,
              height: 30.h,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    padding: EdgeInsets.all(8),
                    color: Color.fromARGB(255, 137, 137, 137).withOpacity(.8),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 70),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.user.judulLive} ',
                              style: fontStyle10,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              '${timeago.format(widget.user.createdAt)}',
                              style: fontStyle7,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: -12,
              child: Lottie.asset(
                "assets/lottie/live.json",
              ),
              width: 16.w,
              height: 10.h,
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(GetRoutes.livedetail,
                        arguments: LiveDetail(detail: widget.user));
                  },
                  splashColor: Colors.teal[200],
                  splashFactory: InkSplash.splashFactory,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
