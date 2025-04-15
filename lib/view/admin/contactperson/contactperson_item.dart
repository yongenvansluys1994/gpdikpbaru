import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/admin/inputcontactperson_controller.dart';
import 'package:gpdikpbaru/models/model_contactperson.dart';
import 'package:gpdikpbaru/view/admin/contactperson/widgets/bottomsheet.dart';

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
                    controller.NamaCon.text = user.nama;
                    controller.No_HPCon.text = user.noHp;
                    controller.AlamatCon.text = user.alamat;
                    controller.KetCon.text = user.ket;
                    controller.image_url.value = user.urlGambar;
                    tambah_bottom(aksi: "edit", Id: user.id, context: context);
                  },
                  backgroundColor: Color.fromARGB(255, 67, 67, 67),
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    controller.delete(user.id);
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
                "${user.urlGambar}",
                fit: BoxFit.fill,
                height: 6.h,
                width: 12.w,
              )),
              title: Text('${user.nama}'),
              subtitle: Text(
                '${user.ket}..',
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
