import 'package:flutter/widgets.dart';
import 'package:manga/feature/library/presentation/view/LibraryScreen.dart';
import 'package:manga/feature/loading/presentation/view/LoadingScreen.dart';
import 'package:manga/feature/manga/details/data/model/MandaDetailParameter.dart';
import 'package:manga/feature/manga/details/presentation/view/MangaDetailScreen.dart';
import 'package:manga/feature/manga/reader/data/model/ReaderParameter.dart';
import 'package:manga/feature/manga/reader/presentation/view/ReaderScreen.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailScreen.dart';
import 'package:manga/feature/profile/auth/registration/presentation/view/AuthRegistrationScreen.dart';
import 'package:manga/main.dart';

final GlobalKey<NavigatorState> navigator = new GlobalKey<NavigatorState>();
class MangaRoute {
  static const String ROOT = "/";
  static const String HOME = "/home";
  static const String LIBRARY = "/library";
  static const String LOADING = "/loading";
  static const String MANGA_DETAIL = "/manga/detail";
  static const String MANGA_READER = "/manga/reader";
//  static const String MANGA_AUTH = "/manga/auth";
  static const String MANGA_AUTH_EMAIL = "/manga/auth/email";
  static const String MANGA_AUTH_REGISTRATION = "/manga/auth/registration";
}

var appRoute = {
  MangaRoute.ROOT: (BuildContext context, {dynamic arguments}) =>
      LoadingScreen(),
  MangaRoute.LOADING: (BuildContext context, {dynamic arguments}) =>
      LoadingScreen(),
  MangaRoute.LIBRARY: (BuildContext context, {dynamic arguments}) =>
      LibraryScreen(),
  MangaRoute.HOME: (BuildContext context, {dynamic arguments}) =>
      LibraryScreen(),
  MangaRoute.MANGA_DETAIL: (BuildContext context, {dynamic arguments}) =>
      MangaDetailScreen(arguments),
  MangaRoute.MANGA_READER: (BuildContext context, {dynamic arguments}) =>
      ReaderScreen(arguments),
//  MangaRoute.MANGA_AUTH: (BuildContext context, {dynamic arguments}) =>
//      AuthScreen(),
  MangaRoute.MANGA_AUTH_EMAIL: (BuildContext context, {dynamic arguments}) =>
      AuthEmailScreen(),
  MangaRoute.MANGA_AUTH_REGISTRATION: (BuildContext context, {dynamic arguments}) =>
      AuthRegistrationScreen(),
};

class MangaNavigator {

  static pop([Object value]) => navigator.currentState.pop(value);

  static Future<Object> openHome() => _open(MangaRoute.HOME, type: NavigationType.REPLACE);

  static Future<Object> openLibrary() => _open(MangaRoute.LIBRARY, type: NavigationType.REPLACE);

  static Future<Object> openLoader() => _open(MangaRoute.LOADING, type: NavigationType.REPLACE);

  static Future<Object> openAuthScreen() => _open(MangaRoute.MANGA_AUTH_EMAIL);

//  static void openEmailScreen() => _open(MangaRoute.MANGA_AUTH_EMAIL);

  static Future<Object> openRegistrationScreen() => _open(MangaRoute.MANGA_AUTH_REGISTRATION);

  static Future<Object> openDetailsScreen(MangaDetailParameter parameters) =>
      _open(MangaRoute.MANGA_DETAIL, arguments: parameters);

  static Future<Object> openReaderScreen(ReaderParameter parameters) =>
      _open(MangaRoute.MANGA_READER, arguments: parameters);

  static Future<Object> _open(String path, {NavigationType type, dynamic arguments}) {
    if (type == NavigationType.REPLACE) {
      logger.d("replace screen: $path");
      return navigator.currentState.pushReplacementNamed(path, arguments: arguments);
    } else {
      logger.d("push screen: $path");
      return navigator.currentState.pushNamed(path, arguments: arguments);
    }
  }
}

enum NavigationType {
  PUSH, REPLACE
}
