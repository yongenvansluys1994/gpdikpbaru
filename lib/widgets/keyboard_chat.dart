import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

Widget keyboard_chat(session_C) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: RichText(
        text: TextSpan(children: [
      WidgetSpan(
        child: SizedBox(
          height: 30,
          width: 30,
          child: ClipOval(
              child: Image.network(
            "${session_C.fotoprofil}",
            height: 3.7.h,
            fit: BoxFit.cover,
          )),
        ),
      )
    ])),
  );
}
