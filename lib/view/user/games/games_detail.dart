// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';

import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';

import 'package:webview_flutter/webview_flutter.dart';

class GamesDetail extends StatefulWidget {
  const GamesDetail({super.key});

  @override
  State<GamesDetail> createState() => _GamesDetailState();
}

class _GamesDetailState extends State<GamesDetail> {
  late Map<String, dynamic> dataGames; // Variabel untuk menyimpan data
  late final WebViewController _controller;
  bool isLoading = true; // Indikator loading

  final poiniman_controller poiniman_C = Get.find();
  @override
  void initState() {
    super.initState();

    // Ambil data dari Get.arguments
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      dataGames = Get.arguments['dataGames'];
    } else {
      throw Exception("Invalid arguments passed to GamesDetail");
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true; // Tampilkan loading saat halaman mulai dimuat
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading =
                  false; // Sembunyikan loading saat halaman selesai dimuat
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('${dataGames['url']}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: dataGames['nm_game'] ?? "Games", // Gunakan nama game
        leading: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(
              controller: _controller), // WebView untuk memuat halaman
          if (isLoading) // Tampilkan loading jika halaman belum selesai dimuat
            Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
              bottom: 0,
              child: poiniman_C.add_poin_transparant(
                  task: "poin_task9", poin: 0.001, text: "+1", seconds: 120))
        ],
      ),
    );
  }
}
