import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget wrapCircleTransparentClick(Widget widget, Function fun) {
  return Material(
    color: Colors.transparent,
    child: Center(
      child: InkWell(
        customBorder: new CircleBorder(),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
          child: widget,
        ),
        onTap: fun,
      ),
    ),
  );
}