import 'package:manga/feature/strategy/data/model/MangaDetails.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/source/StrategyHolder.dart';

import '../../../main.dart';

class MangaContext {

  StrategyHolder currentStrategy;

  void setStrategy(StrategyHolder strategy) {
    currentStrategy = strategy;
  }

  Future<MangaDetail> executeStrategyDetails(MangaItem manga) async {
    var mangaStrategy = currentStrategy.mangaStrategy;
    return await mangaStrategy.getMangaDetail(manga);
  }

  Future<List<MangaItem>> executeStrategyList(int page) async {
    var mangaStrategy = currentStrategy.mangaStrategy;
    var paginationController = currentStrategy.paginationController;
    return await mangaStrategy.getMangas(paginationController.getPagination(page));
  }

  Future<List<MangaItem>> search(String search, int page) async {
    var mangaStrategy = currentStrategy.mangaStrategy;
    var paginationController = currentStrategy.paginationController;
    return await mangaStrategy.search(search, paginationController.getPagination(page));
  }
}
