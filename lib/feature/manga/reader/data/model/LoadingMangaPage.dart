import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';

class LoadingMangaPage extends MangaPage {

  InitialPagePosition direction;

  LoadingMangaPage(Chapter parent, this.direction) : super("", parent);
}

enum InitialPagePosition {
  START, END
}