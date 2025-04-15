import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:gpdikpbaru/common/responsive.dart';
import 'package:gpdikpbaru/common/styles.dart';
import 'package:gpdikpbaru/controller/games/games_controller.dart';

import 'package:gpdikpbaru/routes/routes.dart';

import 'package:sizer/sizer.dart';

class GamesPage extends GetView<Games_Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(), // Tampilkan loading indikator
          );
        }

        if (controller.gameList.isEmpty) {
          return Center(
            child: Text("Tidak ada data game."),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Jumlah kolom
            crossAxisSpacing: 8.0, // Jarak horizontal antar item
            mainAxisSpacing: 8.0, // Jarak vertikal antar item
            childAspectRatio: 4 / 4, // Rasio lebar dan tinggi item
          ),
          itemCount: controller.gameList.length,
          itemBuilder: (context, index) {
            final games = controller.gameList[index];
            return InkWell(
              onTap: () {
                Get.toNamed(
                  GetRoutes.gamedetail,
                  arguments: {'dataGames': games}, // Kirim data sebagai Map
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 1),
                      blurRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 15.w,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${games['url_gambar']}"),
                        radius: 14.w,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${games['nm_game']}',
                        style: defaultFontBold.copyWith(
                          fontSize: Responsive.FONT_SIZE_DEFAULT,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
