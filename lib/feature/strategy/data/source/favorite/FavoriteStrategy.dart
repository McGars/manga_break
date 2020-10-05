import 'dart:async';

import 'package:manga/feature/firebase/use_case/FirebaseDatabaseUseCase.dart';
import 'package:manga/feature/strategy/data/model/Chapter.dart';
import 'package:manga/feature/strategy/data/model/MangaDetails.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/feature/strategy/data/model/MangaPage.dart';
import 'package:manga/feature/strategy/data/model/Pagination.dart';
import 'package:manga/feature/strategy/data/source/MangaStrategy.dart';
import 'package:manga/feature/strategy/data/source/StrategyHolder.dart';
import 'package:manga/feature/strategy/data/util/strategies_util.dart';

class FavoriteStrategy implements MangaStrategy {

  static const String host = "favorite";

  FirebaseDatabaseUseCase _firebaseDatabaseUseCase;

  FavoriteStrategy(this._firebaseDatabaseUseCase);

  @override
  Future<MangaDetail> getMangaDetail(MangaItem manga) {
    return _getStrategyHolder(manga.url)
      .then((holder) => holder.mangaStrategy)
      .then((strategy) => strategy.getMangaDetail(manga));
  }

  @override
  Future<List<MangaPage>> getMangaPage(Chapter chapter) {
    return _getStrategyHolder(chapter.url)
        .then((holder) => holder.mangaStrategy)
        .then((strategy) => strategy.getMangaPage(chapter));
  }

  @override
  Future<List<MangaItem>> getMangas(Pagination pagination) {
    if (pagination.page > 0) return Future.value([]);
    return Future.value(_firebaseDatabaseUseCase.favorites.values)
        .then((value) => value.where((e) => e.isFavorite))
        .then((value) => value.map((e) => MangaItem.fromFavorite(e)).toList());
  }

  @override
  Future<List<MangaItem>> search(String query, Pagination pagination) {
    if (pagination.page > 0) return Future.value([]);
    var lowerCaseQuery = query.toLowerCase();
    return Future.value(_firebaseDatabaseUseCase.favorites.values)
        .then((value) => value.where((element) => element.name.toLowerCase().contains(lowerCaseQuery)))
        .then((value) => value.map((e) => MangaItem.fromFavorite(e)).toList());
  }

  Future<StrategyHolder> _getStrategyHolder(String url) {
    return Future.value(mangaStrategiesName)
        .then((names) => names.firstWhere((name) => url.contains(name)))
        .then((name) => mangaStrategies[name]);
  }
}
