import 'package:flutter/material.dart';


class SlideTransitionFromLeftToRight {

  static SlideTransition getTransition(Animation<double> animation, Widget child) {
    var begin = Offset(1.0, 0.0);
    var end = Offset.zero;
    var curve = Curves.linearToEaseOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

}