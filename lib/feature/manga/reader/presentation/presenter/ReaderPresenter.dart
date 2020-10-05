import 'dart:async';

import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/feature/manga/reader/data/model/LoadingMangaPage.dart';
import 'package:manga/feature/manga/reader/data/model/ReaderPageData.dart';
import 'package:manga/feature/manga/reader/data/model/ReaderParameter.dart';
import 'package:manga/feature/manga/reader/domain/PageCacheUseCase.dart';
import 'package:manga/feature/manga/reader/presentation/view/ReaderState.dart';
import 'package:manga/feature/manga/reader/presentation/view/ReaderView.dart';
import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';

class ReaderPresenter extends BasePresenter<ReaderView> {
  ReaderParameter _parameter;
  ReaderState _state = ReaderState();
  PageCacheUseCase _pages;

  int _currentChapterPosition;
  int _lastSelectedPage = -1;
  List<MangaPage> _previousPages;

  StreamController _controller = StreamController<ReaderPageData>();

  Stream<ReaderPageData> get _pagesStrim => _controller.stream;

  ReaderPresenter(this._parameter) {
    _pages = PageCacheUseCase(_parameter.chapters, _parameter.strategy);
  }


  @override
  void initState() async {
    _currentChapterPosition = _parameter.currentChapterPosition;

    _pages.pages.listen(handleChapterPages);
    
    view.bindState(_state.bind(
      pages: _pagesStrim,
      initialPosition: 0,
    ));

    await _pages.loadChapterPages(_currentChapterPosition);
  }
  
  void handleChapterPages(List<MangaPage> pages) {

    var initialPositionDirection = _lastSelectedPage == 0 ? InitialPagePosition.END : InitialPagePosition.START;
    var initialPosition = 0;

    // TODO оптимизировать last
    var lastChapter = pages.last.parent;
    var chapterLastPosition = getChapterPosition(lastChapter);
    if (_parameter.chapters.length - 1 > chapterLastPosition) {
      pages.add(LoadingMangaPage(lastChapter, InitialPagePosition.END));
      if (initialPositionDirection == InitialPagePosition.END) {
        initialPosition = pages.length - 2;
      }
    } else if (initialPositionDirection == InitialPagePosition.END) {
      initialPosition = pages.length - 1;
    }

    var firstChapter = pages.first.parent;
    var chapterFistPosition = getChapterPosition(firstChapter);
    if (chapterFistPosition > 0) {
      if (initialPositionDirection == InitialPagePosition.START) {
        initialPosition = 1;
      }
      pages.insert(0, LoadingMangaPage(firstChapter, InitialPagePosition.START));
    }

    _previousPages = pages;

    _controller.add(ReaderPageData(pages, initialPosition));
  }

  void onPageChanged(int page) {
    _lastSelectedPage = page;

    if (_previousPages == null) return;

    var currentPage = _previousPages[page];

    if (currentPage is LoadingMangaPage) {
      var chapterPosition = getChapterPosition(currentPage.parent);
      if (chapterPosition >= 0) {
        _pages.loadChapterPages(chapterPosition - (page == 0 ? 1 : -1));
      }
    }

  }

  int getChapterPosition(Chapter chapter) => _parameter.chapters.indexOf(chapter);

//  void loadANdShowPages() async {
//    MangaPage lastSelectedMangaPage;
//    if (_state.pages != null) {
//      lastSelectedMangaPage = _state.pages[_lastSelectedPage ?? 0];
//    }
//    var pages = await _loadChapterPages(_currentChapterPosition)
//        .then((_) => preparePages());
//
//    if (_parameter.chapters.length > _parameter.currentPosition + 1) {
//      pages.add(LoadingMangaPage());
//    }
//
//    var position = await _preparePosition(lastSelectedMangaPage, pages);
//
//    if (_currentChapterPosition > 0 && position == 0) {
//      position = 1;
//    }
//
//    if (_currentChapterPosition > 0) {
//      pages.insert(0, LoadingMangaPage());
//    }
//
//    // todo not call if dispose
//    view.bindState(_state.bind(
//      pages: pages,
//      initialPosition: position,
//    ));
//  }

//  Future<int> _preparePosition(MangaPage lastSelectedMangaPage, List<MangaPage> pages) {
//    return Future.value(pages).then((value) async {
//      if (lastSelectedMangaPage == null) return 0;
//      var position = value.indexWhere((element) => element.url == lastSelectedMangaPage.url);
//      if (position >= 0) return position;
//      else return 0;
//    });
//  }
//
//  Future<List<MangaPage>> preparePages() {
//    return Future.value(_pages).then((value) async {
//      List<MangaPage> list = [];
//      value.forEach((key, value) {
//        list.addAll(value);
//      });
//      return list;
//    });
//  }
//
//  Future<void> _loadChapterPages(int position) async {
//    if (_pages.containsKey(position)) return;
//    var chapter = _parameter.chapters[position];
//    var chapterPages = await _parameter.strategy.getMangaPage(chapter);
//    _pages[position] = chapterPages;
//  }
@override
  void dispose() {
    _controller.close();
    super.dispose();
  }

}
