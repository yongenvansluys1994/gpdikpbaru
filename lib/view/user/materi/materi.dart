import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/materi/materi_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/view/user/materi/bottomsheet.dart';
import 'package:gpdikpbaru/widgets/easythrottle.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Materi extends GetView<Materi_Controller> {
  @override
  Widget build(BuildContext context) {
    var selectedfABLocation = FloatingActionButtonLocation.endDocked;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Materi Komsel & Ibadah",
        leading: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.materiList.isEmpty) {
          return Center(
            child: CircularProgressIndicator(), // Tampilkan loading indikator
          );
        }

        if (controller.materiList.isEmpty) {
          return Center(
            child: Text("Tidak ada data materi."),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoadingMore.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !controller.hasReachedMax.value) {
              controller.fetchMateri(isLoadMore: true); // Fetch data berikutnya
            }
            return false;
          },
          child: ListView.builder(
            itemCount: controller.materiList.length +
                1, // Tambahkan 1 untuk indikator loading
            itemBuilder: (context, index) {
              if (index == controller.materiList.length) {
                // Tampilkan indikator loading di bagian bawah
                if (controller.isLoadingMore.value) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (controller.hasReachedMax.value) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Semua data telah dimuat."),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }

              final materi = controller.materiList[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading:
                      Icon(Icons.picture_as_pdf, color: Colors.red), // Ikon PDF
                  title: Text(materi['nm_pdf'] ?? "Unknown PDF"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kategori: ${materi['kategori']}"),
                      // Text(
                      //     "Total Downloads: ${materi['downloads']}"), // Total downloads
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Pastikan ukuran Row hanya sebesar kontennya
                    children: [
                      IconButton(
                        icon: Icon(Icons.download,
                            color: Colors.blue), // Ikon download
                        onPressed: () async {
                          final url = materi['url_pdf'];
                          if (await canLaunch(url)) {
                            await launch(url); // Buka URL untuk mendownload PDF
                          } else {
                            print("Could not launch $url");
                          }
                        },
                      ),
                      controller.dataProfil.isNotEmpty &&
                              controller.dataProfil[0].level == "admin"
                          ? IconButton(
                              icon: Icon(Icons.delete,
                                  color: Colors.red), // Ikon delete
                              onPressed: () {
                                // Tambahkan logika untuk menghapus materi
                                easyThrottle(
                                  handler: () {
                                    controller.delete(materi['id'].toString());
                                  },
                                );
                              },
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButtonLocation: controller.dataProfil.isNotEmpty &&
              controller.dataProfil[0].level == "admin"
          ? selectedfABLocation
          : null, // Tampilkan jika level adalah admin
      floatingActionButton: controller.dataProfil.isNotEmpty &&
              controller.dataProfil[0].level == "admin"
          ? SpeedDial(
              backgroundColor: CtrMainColor,
              icon: Icons.add,
              activeIcon: Icons.close,
              spacing: 3,
              childPadding: const EdgeInsets.all(5),
              spaceBetweenChildren: 4,
              onPress: () {
                tambahmateri_bottom(aksi: "input", Id: "", context: context);
              },
            )
          : null, // Tampilkan jika level adalah admin
      bottomNavigationBar: controller.dataProfil.isNotEmpty &&
              controller.dataProfil[0].level == "admin"
          ? BottomAppBar(
              color: CtrMainColor,
              shape: const CircularNotchedRectangle(),
              notchMargin: 8.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 6.h,
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.h),
                      child: Text(
                        "Klik Tombol + untuk Menambah Data",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 239, 239, 239)),
                      ),
                    )),
                  )
                ],
              ),
            )
          : null, // Tampilkan jika level adalah admin
    );
  }
}
