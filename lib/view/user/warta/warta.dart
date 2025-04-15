import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/common/constants.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/jadwal/jadwal_controller.dart';
import 'package:gpdikpbaru/controller/themedark_controller.dart';
import 'package:gpdikpbaru/controller/warta/comments_warta_controller.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';

import 'package:gpdikpbaru/controller/warta/warta_controller.dart';
import 'package:gpdikpbaru/models/model_jadwal.dart';
import 'package:gpdikpbaru/routes/routes.dart';
import 'package:gpdikpbaru/view/user/jadwal/widgets/jadwal_card.dart';
import 'package:gpdikpbaru/view/user/top_profil.dart';
import 'package:gpdikpbaru/widgets/easythrottle.dart';
import 'package:gpdikpbaru/widgets/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Warta extends StatefulWidget {
  const Warta({super.key});

  @override
  State<Warta> createState() => _WartaState();
}

class _WartaState extends State<Warta> {
  final ScrollController _scrollController =
      ScrollController(); // Tambahkan ScrollController

  @override
  void dispose() {
    _scrollController.dispose(); // Jangan lupa dispose ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {"title": "IBADAH RAYA MINGGU", "kategori": "ibadah_minggu"},
      {"title": "IBADAH PELPRIP", "kategori": "ibadah_pelprip"},
      {"title": "IBADAH PELWAP", "kategori": "ibadah_pelwap"},
      {"title": "IBADAH PELPRAP", "kategori": "ibadah_pelprap"},
      {"title": "DOA PERSEKUTUAN", "kategori": "doa_persekutuan"},
    ];
    final home_controller2 session_C = Get.find();
    final Warta_Controller controller = Get.find();
    final Jadwal_Controller jadwal_C = Get.find();
    final CommentsWartaController comments_C = Get.find();

    final PageController pageController = PageController(
      initialPage: controller.currentPage.value,
      keepPage: true,
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: "Warta Jemaat Online",
        leading: true,
      ),
      body: Stack(
        children: [
          // PageView untuk konten utama
          Obx(() {
            return PageView.builder(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(), // Disable manual swipe
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                controller.onPageChanged(index); // Call the controller's method
              },
              itemCount: controller.wartaItems.length,
              itemBuilder: (context, weekIndex) {
                final weekItem = controller.wartaItems[weekIndex];
                return Scrollbar(
                  controller: _scrollController, // Hubungkan ScrollController
                  thumbVisibility: true, // Menampilkan indikator scroll
                  thickness: 3.sp, // Ketebalan indikator scroll
                  radius: Radius.circular(10), // Radius sudut indikator scroll
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: ((weekItem['sections'] as List?)?.isEmpty ??
                            true)
                        ? (controller.dataProfil[0].level == "admin"
                            ? 2
                            : 1) // Tambahkan 1 screen putih jika admin dan sections kosong
                        : ((weekItem['sections'] as List?)?.length ?? 0) +
                            1, // Jika sections ada, hanya jadwal ibadah + sections
                    itemBuilder: (context, sectionIndex) {
                      if (sectionIndex == 0) {
                        // Page pertama: Tampilkan jadwal ibadah
                        return Container(
                          height: Get.height,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                weekItem['image'],
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.7),
                                      Colors.black.withOpacity(0.9),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 1.sp,
                                left: 20.sp,
                                right: 20.sp,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${controller.formatDate(weekItem['startDate'])} - ${controller.formatDate(weekItem['endDate'])}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        if (controller.currentPage.value ==
                                            controller.FirstIndex)
                                          AnimatedBuilder(
                                            animation: controller.animation,
                                            builder: (context, child) {
                                              return Container(
                                                width: 21.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color.fromARGB(
                                                      255, 255, 182, 26),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                              255, 255, 71, 71)
                                                          .withOpacity(
                                                        (0.5 +
                                                                0.5 *
                                                                    sin(controller
                                                                            .animation
                                                                            .value *
                                                                        2 *
                                                                        pi))
                                                            .abs(),
                                                      ),
                                                      blurRadius:
                                                          2, // Radius blur shadow
                                                      spreadRadius:
                                                          1.5, // Radius penyebaran shadow
                                                      offset: Offset(-0,
                                                          1), // Posisi shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(2.sp),
                                                  child: Text(
                                                    "MINGGU INI",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 9.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        else
                                          SizedBox.shrink()
                                      ],
                                    ),
                                    Obx(() {
                                      return Container(
                                        child: Column(
                                          children: categories.map((category) {
                                            final jadwalList =
                                                controller.getJadwalByKategori(
                                                    category['kategori']!);
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 7.sp, bottom: 2.sp),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.sp),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 6.sp,
                                                      vertical: 2.sp,
                                                    ),
                                                    child: Text(
                                                      category['title']!,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (jadwalList.isEmpty)
                                                  NoData(
                                                      theme: theme,
                                                      kategori: category,
                                                      level_user: controller
                                                          .dataProfil[0].level,
                                                      startdate:
                                                          weekItem['startDate'],
                                                      enddate:
                                                          weekItem['endDate'])
                                                else
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        jadwalList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final jadwal =
                                                          ModelJadwal.fromJson(
                                                              jadwalList[
                                                                  index]);
                                                      return JadwalCard(
                                                          jadwal: jadwal);
                                                    },
                                                  ),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 13.sp),
                                    Text(
                                      'Scroll kebawah untuk melihat detail warta',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    SizedBox(height: 13.sp),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0.sp,
                                right: 5.5.sp,
                                child: Lottie.asset(
                                  'assets/lottie/scroll_bottom.json',
                                  width: 15.w,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Page berikutnya: Tampilkan sections
                        final sections = weekItem['sections'] as List?;
                        if (sections == null || sections.isEmpty) {
                          if (controller.dataProfil[0].level == "admin" &&
                              sectionIndex == 1) {
                            return Container(
                              height: Get.height,
                              width: Get.width,
                              color: Colors.white,
                              padding: EdgeInsets.all(16.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Upload Gambar Warta Jemaat",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  TextFormField(
                                    controller: controller.tglIbadahController,
                                    decoration: InputDecoration(
                                      labelText: "Tanggal Ibadah Minggu",
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.calendar_today),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (pickedDate != null) {
                                        controller.tglIbadahController.text =
                                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                      }
                                    },
                                  ),
                                  SizedBox(height: 2.h),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      await controller.pickImages();
                                    },
                                    icon: Icon(Icons.image),
                                    label: Text("Pilih Gambar"),
                                  ),
                                  SizedBox(height: 2.h),
                                  Obx(() {
                                    if (controller.selectedImages.isEmpty) {
                                      return Text(
                                        "Belum ada gambar yang dipilih.",
                                        style: TextStyle(color: Colors.grey),
                                      );
                                    }
                                    return Container(
                                      height: 10.h,
                                      child: ReorderableListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          for (int index = 0;
                                              index <
                                                  controller
                                                      .selectedImages.length;
                                              index++)
                                            KeyedSubtree(
                                              key: ValueKey(
                                                  index), // berikan ValueKey dengan index
                                              child:
                                                  ReorderableDragStartListener(
                                                // tambahkan ReorderableDragStartListener di luar Row
                                                index: index, // berikan index
                                                child: Stack(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                FullScreenImage(
                                                              image: controller
                                                                      .selectedImages[
                                                                  index],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Image.file(
                                                        controller
                                                                .selectedImages[
                                                            index],
                                                        width: 55.sp,
                                                        height: 55.sp,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0.sp,
                                                      left: 0.sp,
                                                      child: Container(
                                                        height: 12.sp,
                                                        width: 12.sp,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '${index + 1}',
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: -10.sp,
                                                      right: -10.sp,
                                                      child: IconButton(
                                                        icon: Icon(Icons.close,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          controller.removeImage(
                                                              controller
                                                                      .selectedImages[
                                                                  index]);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                        ],
                                        onReorder: (oldIndex, newIndex) {
                                          if (oldIndex < newIndex) {
                                            newIndex -= 1;
                                          }
                                          final image = controller
                                              .selectedImages
                                              .removeAt(oldIndex);
                                          controller.selectedImages
                                              .insert(newIndex, image);
                                          logInfo(
                                              'Susunan selectedImages setelah di drag: ${controller.selectedImages.map((image) => image.path).toList().join(', ')}');
                                        },
                                      ),
                                    );
                                  }),
                                  SizedBox(height: 1.h),
                                  Obx(() {
                                    return Text(
                                      controller.selectedImages.length > 0
                                          ? "Urutan yang tampil di Warta sesuai dengan urutan gambar yang diupload. Geser gambar untuk ganti susunan gambar"
                                          : "",
                                      style: TextStyle(fontSize: 10.sp),
                                    );
                                  }),
                                  SizedBox(height: 2.h),
                                  ElevatedButton(
                                    onPressed: () async {
                                      easyThrottle(
                                        handler: () async {
                                          await controller.uploadImages();
                                        },
                                      );
                                    },
                                    child: Text("Upload"),
                                  ),
                                ],
                              ),
                            );
                          }
                          // Jika bukan admin, tampilkan teks default
                          return Center(
                            child: Text(
                              "Tidak ada data untuk ditampilkan.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }

                        // Pastikan indeks valid untuk sections
                        if (sectionIndex - 1 < sections.length) {
                          final section = sections[sectionIndex - 1];
                          return Stack(
                            children: [
                              Container(
                                height: Get.height,
                                width: Get.width,
                                child: InteractiveViewer(
                                  panEnabled: true, // Mengaktifkan drag/pan
                                  minScale: 1.0, // Skala minimum (default)
                                  maxScale: 4.0, // Skala maksimum untuk zoom
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(section['content']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Image.network(
                                      section['content'], // URL gambar
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child; // Gambar selesai dimuat
                                        } else {
                                          return Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          (loadingProgress
                                                                  .expectedTotalBytes ??
                                                              1)
                                                      : null, // Progress bar
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "Sedang memuat gambar...",
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        return Center(
                                          child: Text(
                                            "Gagal memuat gambar",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              controller.dataProfil[0].level == "admin"
                                  ? Positioned(
                                      bottom: 2,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // kode untuk hapus gambar warta jemaat
                                            Get.defaultDialog(
                                              content: Column(
                                                children: [
                                                  Text(
                                                    "Hapus Gambar Warta Jemaat ?",
                                                    style: TextStyle(
                                                        fontSize: 15.sp),
                                                  ),
                                                  SizedBox(height: 3.h),
                                                  Text(
                                                    "Jika anda menghapusnya, semua Gambar Warta Jemaat di minggu ini terhapus, tidak bisa 1-1.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12.sp),
                                                  ),
                                                  SizedBox(height: 3.h),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            controller
                                                                .deleteImagesWarta();
                                                          },
                                                          child: Text("Hapus"),
                                                        ),
                                                      ),
                                                      SizedBox(width: 16),
                                                      Expanded(
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text("Batal"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child:
                                              Text("Hapus Gambar Warta Jemaat"),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          );
                        } else {
                          // Jika indeks tidak valid, tampilkan halaman kosong
                          return SizedBox.shrink();
                        }
                      }
                    },
                  ),
                );
              },
            );
          }),
          // Navigation buttons positioned at the top
          Positioned(
            top: 5.sp,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50.sp,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.currentPage.value > 0) {
                            // Animate to previous page
                            pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CtrMainColor,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(6)),
                          ),
                        ),
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: Icon(Icons.arrow_back,
                              color: Colors.white, size: 15.sp),
                        ),
                      ),
                    ),
                    Obx(() => Text(
                          controller
                              .getMonthWeekText(controller.currentPage.value),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(
                      width: 50.sp,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.currentPage.value <
                              controller.wartaItems.length - 1) {
                            // Animate to next page
                            pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CtrMainColor,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(6)),
                          ),
                        ),
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: Icon(Icons.arrow_forward,
                              color: Colors.white, size: 15.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final File image;

  FullScreenImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Get.back(); // tambahkan ini
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(image),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.theme,
    required this.kategori,
    required this.startdate,
    required this.enddate,
    required this.level_user,
  });

  final themedark theme;
  final Map<String, String> kategori;
  final DateTime startdate;
  final DateTime enddate;
  final String level_user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                lightBlueColor,
                Color.fromARGB(255, 116, 205, 219),
              ]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
                topRight: Radius.circular(48),
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 7,
                    offset: Offset(5, 5),
                    color: lightBlueColor.withOpacity(0.4)),
                BoxShadow(
                    blurRadius: 7,
                    offset: Offset(-2, -2),
                    color: lightBlueColor.withOpacity(0.4))
              ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: SizedBox(
              height: 10.h,
              child: Row(
                children: [
                  Container(
                    width: 88,
                    color: theme.isLightTheme.value
                        ? Colors.blueGrey
                        : CtrMainDark,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 15.w,
                          child: Text(
                            '  ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(),
                            children: [
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 241, 241, 241),
                                  fontSize: 8.sp,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: theme.isLightTheme.value ? CtrWhite : CtrWhite3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Text(
                              'Tidak ada Jadwal',
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (level_user == "admin") {
                  Get.toNamed(GetRoutes.jadwalinput, arguments: [
                    kategori['kategori'],
                    kategori['title'],
                    startdate,
                    enddate,
                  ]);
                }
              },
              splashColor: Colors.teal[200],
              splashFactory: InkSplash.splashFactory,
            ),
          ),
        ),
      ],
    );
  }
}
