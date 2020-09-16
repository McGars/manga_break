import 'package:manga/core/state/BaseState.dart';
import 'package:manga/feature/manga/reader/data/model/ReaderPageData.dart';

class ReaderState implements BaseState {

  Stream<ReaderPageData> pages;
  int initialPosition = 0;

  ReaderState bind({Stream<ReaderPageData> pages, int initialPosition}) {
    this.pages = pages ?? this.pages;
    this.initialPosition = initialPosition ?? this.initialPosition;
    return this;
  }
}
