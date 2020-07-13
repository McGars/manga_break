import 'package:manga/feature/firebase/data/model/FirebaseFavorite.dart';
import 'package:manga/feature/firebase/data/repository/FirebaseDatabaseApi.dart';
import 'package:manga/feature/firebase/use_case/MangaFirebaseClient.dart';
import 'package:manga/feature/profile/personal/domain/model/MangaUser.dart';

class FirebaseDatabaseRepository {
  MangaFirebseClient _firebaseClient;

  FirebaseDatabaseRepository(this._firebaseClient);

  Future<Map<String, FavoriteBody>> syncData(MangaUser user) async {
    var uri = FirebaseDatabaseApi.getFavoriteUri(
        user.firebaseIdToken, user.firebaseLocalId
    );
    Map<String, dynamic> response = await _firebaseClient.get(uri);
    return response.map((key, value) => MapEntry(key, FavoriteBody.fromJson(value)));
  }

  Future<dynamic> addToFavorite(String id, FavoriteBody favoriteBody, MangaUser user) async {
    var uri = FirebaseDatabaseApi.getFavoriteUri(
        user.firebaseIdToken, user.firebaseLocalId
    );
    return _firebaseClient.patch(
        uri, FaribaseFavorite(id, favoriteBody)
    );
  }

  Future<dynamic> removeFromFavorite(String id, FavoriteBody favoriteBody, MangaUser user) async {
    var uri = FirebaseDatabaseApi.getFavoriteUri(
        user.firebaseIdToken, user.firebaseLocalId
    );
    return _firebaseClient.patch(
        uri, FaribaseFavorite(id, favoriteBody)
    );
  }
}
