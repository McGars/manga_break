import 'dart:async';

import 'package:manga/feature/manga/reader/repository/PageSource.dart';
import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';
import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';

class PageCacheUseCase {
  List<Chapter> _chapters;

  MangaStrategy _mangaStrategy;

  final Map<int, PagesSource> _pages = {};

  StreamController _controller = StreamController<List<MangaPage>>();

  Stream<List<MangaPage>> get pages => _controller.stream;

  PageCacheUseCase(this._chapters, this._mangaStrategy);

  Future<void> loadChapterPages(int position) async {
    var pageSource = _pages[position];
    if (pageSource == null) {
      var chapter = _chapters[position];
      pageSource = PagesSource(_mangaStrategy, chapter);
      _pages[position] = pageSource;
    }

    if (!pageSource.isLoading) {
       pageSource.loadMangaPage().then((_) => _pages.values
          .where((element) => element.hasData())
          .map((value) => value.getMangaPage()))
          .then((value) {
            var list = value.reduce((value, element) {
              value.addAll(element);
              return value;
            });
            _controller.add(list);
          })
       ;
    }
  }

  void dispose() {
    _controller.close();
  }
}

enum PageSourceDirection { LEFT, RIGHT }
