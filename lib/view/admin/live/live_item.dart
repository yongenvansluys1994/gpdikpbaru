import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/admin/inputlive_controller.dart';
import 'package:gpdikpbaru/models/model_datalive.dart';

import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/admin/live/live_detail.dart';
import 'package:gpdikpbaru/view/admin/live/widgets/bottomsheet.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class LiveItemAdmin extends StatelessWidget {
  final ModeldataLive user;
  final inputLiveController controller = Get.put(inputLiveController());
  LiveItemAdmin(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(GetRoutes.livedetail, arguments: LiveDetail(detail: user));
      },
      child: Column(
        children: [
          Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  // flex: 2,
                  onPressed: (context) {
                    controller.judul_liveCon.text = user.judulLive;
                    controller.url_liveCon.text = user.urlLive;
                    tambahlive_bottom(
                        aksi: "edit", Id: user.idLive, context: context);
                  },
                  backgroundColor: Color.fromARGB(255, 67, 67, 67),
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    controller.delete(user.idLive);
                  },
                  backgroundColor: Color.fromARGB(255, 115, 149, 196),
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: ListTile(
              visualDensity: VisualDensity(vertical: -4),
              contentPadding: EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 12,
              ),
              leading: ClipOval(
                  child: Image.network(
                "https://img.youtube.com/vi/${user.urlLive}/0.jpg",
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/images/default-img.png");
                },
                fit: BoxFit.fill,
                height: 6.h,
                width: 12.w,
              )),
              title: Text('${user.judulLive}'),
              subtitle: Text(
                '${DateFormat.yMMMd().format(user.createdAt)}',
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[],
              ),
            ),
          ),
          Divider(
            height: 0.0,
            indent: 76.0,
            endIndent: 10.0,
          )
        ],
      ),
    );
  }
}
