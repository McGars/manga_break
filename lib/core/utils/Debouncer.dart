import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:manga/main.dart';

class Debouncer {
  final int milliseconds;
  Timer _timer;

  Debouncer({this.milliseconds = 400});

  void run(VoidCallback action) {
    logger.d("milliseconds: $milliseconds");
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
