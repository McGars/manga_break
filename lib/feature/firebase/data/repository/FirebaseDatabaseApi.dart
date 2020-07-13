import 'package:manga/core/firebase/FirebaseUtil.dart';

class FirebaseDatabaseApi {

  /// Add to a list of data in our Firebase database.
  /// Every time we send a POST request,
  /// the Firebase client generates a unique key,
  /// like messages/users/<unique-id>/<data>
  static Uri getFavoriteUri(String idToken, String userId) => _build("/favorite/$userId.json", idToken);
  
  /*
  * Build default parameters
  * */
  static Uri _build(String path, String idToken) {
    var params = {"auth": idToken};
    return Uri.https(FirebaseSettings.DATABASE_HOST, path, params);
  }

}
