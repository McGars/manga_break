import 'package:flutter/material.dart';


class PageTransition {

  static SlideTransition getTransitionFromLeftToRight(Animation<double> animation, Widget child) {
    var begin = Offset(1.0, 0.0);
    var end = Offset.zero;
    var curve = Curves.linearToEaseOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
  static FadeTransition getTransitionFade(Animation<double> animation, Widget child) {
    return new FadeTransition(
        opacity: animation,
        child: child
    );
  }

}