import 'package:manga/core/firebase/FirebaseUtil.dart';

class FirebaseAuthApi {

  /*
   * curl 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]' \
   *   -H 'Content-Type: application/json' \
   *  --data-binary '{"email":"[user@example.com]","password":"[PASSWORD]","returnSecureToken":true}'
   * 
   * response
   * {
      "idToken": "[ID_TOKEN]",
      "email": "[user@example.com]",
      "refreshToken": "[REFRESH_TOKEN]",
      "expiresIn": "3600",
      "localId": "tRcfmLH7..."
     }
   */
  static Uri getRegistraionUri() => _build("/v1/accounts:signUp");

  /*
  * https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]
  * */
  static Uri getRefreshTokenUri() => _build("/v1/token");

  /*
  * https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]
  * */
  static Uri getAuthUri() => _build("/v1/accounts:signInWithPassword");

  /*
  * https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=[API_KEY]
  * */
  static Uri getVerifyEmailUri() => _build("/v1/accounts:sendOobCode");

  /*
  * https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=[API_KEY]
  * */
  static Uri getUserData() => _build("/v1/accounts:lookup");

  /*
  * Build default parameters
  * */
  static Uri _build(String path) {
    var params = {"key": FirebaseSettings.API_KEY};
    return Uri.https(FirebaseSettings.AUTH_HOST, path, params);
  }
}
