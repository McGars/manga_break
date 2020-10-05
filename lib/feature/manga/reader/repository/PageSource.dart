import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';
import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';

class PagesSource {

  var isLoading = false;

  List<MangaPage> _pages;
  MangaStrategy _mangaStrategy;
  Chapter _chapter;

  PagesSource(this._mangaStrategy, this._chapter);

  List<MangaPage> getMangaPage() => _pages.toList() ?? <MangaPage>[];

  Future<List<MangaPage>> loadMangaPage() async {
    if (_pages != null) return Future.delayed(Duration(milliseconds: 300)).then((value) => getMangaPage());
    else {
      isLoading = true;
      return _mangaStrategy
        .getMangaPage(_chapter)
        .then((value) => _pages = value)
        .then((value) => getMangaPage())
        .whenComplete(() => isLoading = false);
    }
  }

  bool hasData() => _pages != null;
}