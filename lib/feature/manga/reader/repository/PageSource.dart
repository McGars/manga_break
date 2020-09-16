import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';
import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';

class PagesSource {

  var isLoading = false;

  List<MangaPage> _pages;
  MangaStrategy _mangaStrategy;
  Chapter _chapter;

  PagesSource(this._mangaStrategy, this._chapter);

  List<MangaPage> getMangaPage() => _pages ?? <MangaPage>[];

  Future<List<MangaPage>> loadMangaPage() async {
    if (_pages != null) return _pages;
    else {
      isLoading = true;
      return _mangaStrategy
        .getMangaPage(_chapter)
        .then((value) => _pages = value)
        .whenComplete(() => isLoading = false);
    }
  }

  bool hasData() => _pages != null;
}