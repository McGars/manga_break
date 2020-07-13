import 'package:manga/feature/strategy/data/source/StrategyHolder.dart';
import 'package:manga/feature/strategy/data/source/favorite/FavoritePaginationController.dart';
import 'package:manga/feature/strategy/data/source/favorite/FavoriteStrategy.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaPaginationController.dart';
import 'package:manga/feature/strategy/data/source/readmanga/ReadMangaStrategy.dart';
import 'package:manga/main.dart';

Map<String, StrategyHolder> _mangaStrategies;

Map<String, StrategyHolder> get mangaStrategies {
  var strategies = _mangaStrategies ??
      <String, StrategyHolder>{
        ReadMangaStrategy.host: StrategyHolder(
          MyApp.injector.get<ReadMangaStrategy>(),
          MyApp.injector.get<ReadMangaPaginationController>(),
        ),
        FavoriteStrategy.host: StrategyHolder(
          MyApp.injector.get<FavoriteStrategy>(),
          MyApp.injector.get<FavoritePaginationController>(),
        ),
      };
  return _mangaStrategies = strategies;
}

List<String> get mangaStrategiesName => mangaStrategies.keys.toList();