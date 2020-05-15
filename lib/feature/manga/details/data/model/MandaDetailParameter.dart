import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';

class MangaDetailParameter {
  MangaItem item;
  MangaStrategy strategy;

  MangaDetailParameter(this.item, this.strategy);
}