// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpdikpbaru/controller/home_controller2.dart';
import 'package:gpdikpbaru/controller/poiniman_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/widgets/myclipper.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_flutter_android/webview_flutter_android.dart';

import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class alkitabPage extends StatefulWidget {
  const alkitabPage({super.key});

  @override
  State<alkitabPage> createState() => _alkitabPageState();
}

class _alkitabPageState extends State<alkitabPage> {
  final home_controller2 session_C = Get.find();
  final poiniman_controller poiniman_C = Get.find();
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse('https://alkitab.me/'));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
            clipper: MyClipperSmall(),
            child: Container(
              color: Color.fromARGB(255, 133, 219, 207),
            )),
        Scaffold(
          extendBodyBehindAppBar: false,
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(title: "Alkitab Online", leading: true),
          body: WebViewWidget(controller: _controller),
          floatingActionButton: poiniman_C.add_poin(
              task: "poin_task2", poin: 0.001, text: "+1", seconds: 60),
        ),
      ],
    );
  }
}
