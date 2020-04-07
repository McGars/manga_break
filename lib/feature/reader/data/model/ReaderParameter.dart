import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';

class ReaderParameter {

  List <Chapter> chapters;
  int currentPosition;
  MangaStrategy strategy;

  ReaderParameter(this.chapters, this.currentPosition, this.strategy);
}