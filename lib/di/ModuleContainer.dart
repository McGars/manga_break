import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:manga/core/data/MangaHttp.dart';
import 'package:manga/core/localization/AppLocalizations.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaPaginationController.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaStrategy.dart';
import 'dart:ui' as ui;

import 'package:manga/main.dart';


//    injector.map<String>((i) => "https://api.com/", key: "apiUrl");
//    injector.map<SomeService>(
//            (i) => SomeService(i.get<Logger>(), i.get<String>(key: "apiUrl")));
//
//    injector.map<SomeType>((injector) => SomeType("0"));
//    injector.map<SomeType>((injector) => SomeType("1"), key: "One");
//    injector.map<SomeType>((injector) => SomeType("2"), key: "Two");
//
//    injector.mapWithParams<SomeOtherType>((i, p) => SomeOtherType(p["id"]));

class ModuleContainer {

  Injector initialise(Injector injector) {

    // Core
    injector.map<MangaHttpOverrides>((i) => MangaHttpOverrides(), isSingleton: true);

    // Strategy
    injector.map<ReadMangaStrategy>((i) => ReadMangaStrategy(), isSingleton: true);
    injector.map<ReadMangaPaginationController>((i) => ReadMangaPaginationController(), isSingleton: true);

    // localization
    injector.map<AppLocalizations>((i) => AppLocalizations(ui.window.locale), isSingleton: true);

    return injector;
  }
}

AppLocalizations get appLocalizations => MyApp.injector.get<AppLocalizations>();