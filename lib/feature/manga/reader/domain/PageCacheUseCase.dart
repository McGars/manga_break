import 'dart:async';

import 'package:manga/feature/manga/reader/data/model/ReaderPageData.dart';
import 'package:manga/feature/manga/reader/repository/PageSource.dart';
import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';

class PageCacheUseCase {

  List <Chapter> _chapters;

  MangaStrategy _mangaStrategy;

  final Map<int, PagesSource> _pages = {};

  StreamController _controller = StreamController<ReaderPageData>();

  Stream<ReaderPageData> get pages => _controller.stream;

  PageCacheUseCase(this._chapters, this._mangaStrategy);

  Future<void> _loadChapterPages(int position) async {

    var pageSource = _pages[position];
    if (pageSource == null) {
      var chapter = _chapters[position];
      pageSource = PagesSource(_mangaStrategy, chapter);
      _pages[position] = pageSource;
    }
    
    if (!pageSource.isLoading) {
      pageSource.getMangaPage()
          .then((value) => _controller.add(value));
    }
    
  }

  void dispose() {
    _controller.close()
  }
  
  
}