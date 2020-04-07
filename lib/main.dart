import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:logger/logger.dart';
import 'package:manga/core/data/MangaHttp.dart';
import 'package:manga/core/localization/AppLocalizations.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/route/route.dart';

var logger = Logger();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static var injector = ModuleContainer().initialise(Injector.getInjector());

  MyApp() {
    HttpOverrides.global = injector.get<MangaHttpOverrides>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru'),
        const Locale('en'),
      ],
      title: 'Flutter Demo',
      navigatorKey: navigator,
      theme: CupertinoThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.blue,
      ),
      initialRoute: MangaRoute.HOME,
      routes: appRoute,
    );
  }

}