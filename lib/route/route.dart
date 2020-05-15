import 'package:flutter/widgets.dart';
import 'package:manga/feature/library/presentation/view/LibraryScreen.dart';
import 'package:manga/feature/manga/details/data/model/MandaDetailParameter.dart';
import 'package:manga/feature/manga/details/presentation/view/MangaDetailScreen.dart';
import 'package:manga/feature/manga/reader/data/model/ReaderParameter.dart';
import 'package:manga/feature/manga/reader/presentation/view/ReaderScreen.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailScreen.dart';
import 'package:manga/feature/profile/auth/main/presentation/view/AuthScreen.dart';

final GlobalKey<NavigatorState> navigator = new GlobalKey<NavigatorState>();

class MangaRoute {
  static const String HOME = "/";
  static const String LIBRARY = "/library";
  static const String MANGA_DETAIL = "/manga/detail";
  static const String MANGA_READER = "/manga/reader";
  static const String MANGA_AUTH = "/manga/auth";
  static const String MANGA_AUTH_EMAIL = "/manga/auth/email";
}

var appRoute = {
  MangaRoute.HOME: (BuildContext context, {dynamic arguments}) =>
      LibraryScreen(),
  MangaRoute.LIBRARY: (BuildContext context, {dynamic arguments}) =>
      LibraryScreen(),
  MangaRoute.MANGA_DETAIL: (BuildContext context, {dynamic arguments}) =>
      MangaDetailScreen(arguments),
  MangaRoute.MANGA_READER: (BuildContext context, {dynamic arguments}) =>
      ReaderScreen(arguments),
  MangaRoute.MANGA_AUTH: (BuildContext context, {dynamic arguments}) =>
      AuthScreen(),
  MangaRoute.MANGA_AUTH_EMAIL: (BuildContext context, {dynamic arguments}) =>
      AuthEmailScreen(),
};

class MangaNavigator {
  static void openAuthScreen() => _open(MangaRoute.MANGA_AUTH);

  static void openEmailScreen() => _open(MangaRoute.MANGA_AUTH_EMAIL);

  static void openDetailsScreen(MangaDetailParameter parameters) =>
      _open(MangaRoute.MANGA_DETAIL, arguments: parameters);

  static void openReaderScreen(ReaderParameter parameters) =>
      _open(MangaRoute.MANGA_READER, arguments: parameters);

  static void _open(String path, {dynamic arguments}) =>
      navigator.currentState.pushNamed(path, arguments: arguments);
}
