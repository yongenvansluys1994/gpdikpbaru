import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/controller/admin/inputberita_controller.dart';
import 'package:gpdikpbaru/models/model_databerita.dart';
import 'package:gpdikpbaru/models/model_datarenungan.dart';

import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/admin/berita/berita_detail.dart';
import 'package:gpdikpbaru/view/admin/berita/widgets/bottomsheet.dart';

import 'package:sizer/sizer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BeritaItem extends StatelessWidget {
  final ModeldataRenungan user;
  final inputBeritaController controller = Get.put(inputBeritaController());
  BeritaItem(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(GetRoutes.beritadetail,
            arguments: BeritaDetail(detail: user));
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
                    controller.judul_renunganCon.text = user.judulRenungan;
                    controller.isi_renunganCon.text = user.isiRenungan;
                    controller.image_url.value = user.urlGambar;
                    tambahberita_bottom(
                        aksi: "edit", Id: user.idRenungan, context: context);
                  },
                  backgroundColor: Color.fromARGB(255, 67, 67, 67),
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    controller.delete(user.idRenungan);
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
              title: Text('${user.judulRenungan}'),
              subtitle: Text(
                '${user.isiRenungan}..',
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
