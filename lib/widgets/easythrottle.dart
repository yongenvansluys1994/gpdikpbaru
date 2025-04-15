import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';

easyThrottle({
  required VoidCallback handler,
}) {
  EasyThrottle.throttle("classic", Duration(milliseconds: 2000), handler);
}

easyThrottle5({
  required VoidCallback handler,
}) {
  EasyThrottle.throttle("classic", Duration(milliseconds: 5000), handler);
}
