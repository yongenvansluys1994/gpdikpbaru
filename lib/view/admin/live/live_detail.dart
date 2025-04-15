import 'package:flutter/material.dart';
import 'package:gpdikpbaru/models/model_datalive.dart';

class LiveDetail extends StatelessWidget {
  final ModeldataLive detail;
  const LiveDetail({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    // print(user.email);
    return Scaffold(
      appBar: AppBar(
        title: Text("asd"),
      ),
      body: Text("Asd"),
    );
  }
}
