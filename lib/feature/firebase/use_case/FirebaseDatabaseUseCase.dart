import 'package:manga/feature/firebase/data/model/FirebaseFavorite.dart';
import 'package:manga/feature/firebase/data/repository/FirebaseDatabaseRepository.dart';
import 'package:manga/feature/profile/personal/domain/use_case/MangaUserUseCase.dart';
import 'package:manga/core/utils/StringExtention.dart';
import 'package:manga/feature/strategy/data/model/MangaItem.dart';
import 'package:manga/main.dart';

class FirebaseDatabaseUseCase {
  MangaUserUseCase _mangaUserUseCase;
  FirebaseDatabaseRepository _firebaseDatabaseRepository;

  FirebaseDatabaseUseCase(
    this._mangaUserUseCase,
    this._firebaseDatabaseRepository,
  );

  Map<String, FavoriteBody> favorites = Map();

  bool isInFavorite(String url) {
    logger.d(url);
    logger.d(favorites);
    return favorites[url]?.isFavorite ?? false;
  }

  /// nullable
  FavoriteBody get(String url) => favorites[url];

  Future<void> syncData() async {
    if (_mangaUserUseCase.currentUser.isAuthorize) {
      favorites = await _firebaseDatabaseRepository
          .syncData(_mangaUserUseCase.currentUser)
          .then((value) {
        var map = <String, FavoriteBody>{};
        value.forEach((_, favoriteBody) {
          map[favoriteBody.url] = favoriteBody;
        });
        return map;
      }).catchError((e, stack) {
        return Map<String, FavoriteBody>();
      });
    }
    return favorites;
  }

  Future<void> addToFavorite(MangaItem item) async {
    var id = item.url.md5();
    var favoriteBody = FavoriteBody.fromItem(item);
    favoriteBody.isFavorite = true;
    favorites[item.url] = favoriteBody;
    return _firebaseDatabaseRepository.addToFavorite(
        id, favoriteBody, _mangaUserUseCase.currentUser);
  }

  Future<void> removeFromFavorite(MangaItem item) async {
    var id = item.url.md5();
    var favoriteBody = favorites[item.url] ?? FavoriteBody.fromItem(item);
    favoriteBody.isFavorite = false;
    return _firebaseDatabaseRepository.removeFromFavorite(
        id, favoriteBody, _mangaUserUseCase.currentUser);
  }
}
