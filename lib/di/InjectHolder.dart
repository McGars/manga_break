import 'package:flutter/cupertino.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class InjectHolder {
  static var injectors = <Widget, Injector>{};

  void add(Widget widget, Injector injector) {
    if (injectors.containsKey(widget)) return;
    injectors[widget] = injector;
  }

  List<Injector> get<Widget>() {
    var result = <Injector>[];
    injectors.forEach((key, value) {
      if (key is Widget) result.add(value);
    });
    return result;
  }

  void dispose(widget) {
    var injector = injectors.remove(widget);
    injector.dispose();
  }

}