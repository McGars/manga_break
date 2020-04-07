import 'package:manga/core/state/BaseState.dart';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';

class ReaderState implements BaseState {

  List<MangaPage> pages;
  int initialPosition = 0;

  ReaderState bind({List<MangaPage> pages, int initialPosition}) {
    this.pages = pages ?? this.pages;
    this.initialPosition = initialPosition ?? this.initialPosition;
    return this;
  }
}
