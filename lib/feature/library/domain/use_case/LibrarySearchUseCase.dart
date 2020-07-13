import 'dart:async';
import 'package:manga/feature/library/domain/model/LibraryData.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';

class LibrarySearchUseCase {

  LibraryData _libraryData = LibraryData();

  StreamController _controller = StreamController<LibraryData>();

  Stream<LibraryData> get mangas => _controller.stream;

  void addMangas(List<MangaItem> items) {
    _libraryData.mangas.addAll(items);
    _libraryData.loadMore = items.isNotEmpty;
    _controller.add(_libraryData);
  }

  void setFavorite(String url, bool isFavorite) {
    _libraryData.mangas.firstWhere((element) => element.url == url).isFavorite = isFavorite;
    _controller.add(_libraryData);
  }

  void addErrors(dynamic error, StackTrace stackTrace) {
    _controller.addError(error, stackTrace);
  }

  void clearMangas() {
    _libraryData.mangas.clear();
    _controller.add(null);
  }

  void clearMangasForSearch() {
    _libraryData.mangas.clear();
  }

  void dispose() {
    _controller.close();
  }

}