import 'package:flutter/widgets.dart';
import 'package:manga/feature/library/presentation/view/LibraryScreen.dart';
import 'package:manga/feature/manga_detail/data/model/MandaDetailParameter.dart';
import 'package:manga/feature/manga_detail/presentation/view/MangaDetailScreen.dart';
import 'package:manga/feature/reader/data/model/ReaderParameter.dart';
import 'package:manga/feature/reader/presentation/view/ReaderScreen.dart';

final GlobalKey<NavigatorState> navigator = new GlobalKey<NavigatorState>();

class MangaRoute {
  static const String HOME = "/";
  static const String LIBRARY = "/library";
  static const String MANGA_DETAIL = "/manga/detail";
  static const String MANGA_READER = "/manga/reader";
}

var appRoute = {
  MangaRoute.HOME: (BuildContext context) => LibraryScreen(),
  MangaRoute.LIBRARY: (BuildContext context) => LibraryScreen(),
  MangaRoute.MANGA_DETAIL: (BuildContext context) =>
      MangaDetailScreen(ModalRoute.of(context).settings.arguments),
  MangaRoute.MANGA_READER: (BuildContext context) =>
      ReaderScreen(ModalRoute.of(context).settings.arguments),
};

class MangaNavigator {
  static void openReaderScreen(ReaderParameter parameters) =>
      _open(MangaRoute.MANGA_READER, parameters);

  static void openDetailsScreen(MangaDetailParameter parameters) =>
      _open(MangaRoute.MANGA_DETAIL, parameters);

  static void _open(String path, dynamic parameter) => navigator.currentState
      .pushNamed(path, arguments: parameter);
}
