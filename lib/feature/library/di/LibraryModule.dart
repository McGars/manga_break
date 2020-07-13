import 'package:flutter/foundation.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:manga/feature/library/domain/use_case/LibrarySearchUseCase.dart';

class LibraryModule {
  static Injector inject(Key key) =>
      LibraryModule()._initialise(Injector.getInjector(key.toString()));

  Injector _initialise(Injector injector) {
    injector.map<LibrarySearchUseCase>((i) => LibrarySearchUseCase(), isSingleton: true);

    return injector;
  }
}
