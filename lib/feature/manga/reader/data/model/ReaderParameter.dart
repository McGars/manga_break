import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';

class ReaderParameter {

  List <Chapter> chapters;
  int currentChapterPosition;
  MangaStrategy strategy;

  ReaderParameter(this.chapters, this.currentChapterPosition, this.strategy);
}