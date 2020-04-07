import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';
import 'package:manga/feature/strategy/domain/PaginationController.dart';

class StrategyHolder {

  MangaStrategy mangaStrategy;
  PaginationController paginationController;

  StrategyHolder(this.mangaStrategy, this.paginationController);

}