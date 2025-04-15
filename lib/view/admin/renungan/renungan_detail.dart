import 'package:flutter/material.dart';

import 'package:gpdikpbaru/models/model_datarenungan.dart';

class RenunganDetail extends StatelessWidget {
  final ModeldataRenungan detail;
  const RenunganDetail({
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
