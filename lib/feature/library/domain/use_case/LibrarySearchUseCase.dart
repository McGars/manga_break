import 'dart:async';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';

class LibrarySearchUseCase {

  List<MangaItem> _mangas = [];

  StreamController _controller = StreamController<List<MangaItem>>();

  Stream<List<MangaItem>> get mangas => _controller.stream;

  void addMangas(List<MangaItem> items) {
    _mangas.addAll(items);
    _controller.add(_mangas);
  }

  void addErrors(dynamic error, StackTrace stackTrace) {
    _controller.addError(error, stackTrace);
  }

  void dispose() {
    _controller.close();
  }

}