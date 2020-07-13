import 'package:manga/core/use_case/EncriptUseCase.dart';
import 'package:manga/core/utils/AppLocalizations.dart';
import 'package:manga/feature/firebase/data/model/FirebaseUser.dart';
import 'package:manga/feature/firebase/data/repository/FirebaseAuthRepository.dart';
import 'package:manga/feature/profile/personal/domain/model/MangaUser.dart';
import 'package:manga/feature/strategy/utils/ShredpreferencesUtil.dart';
import 'package:manga/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangaUserUseCase {
  static const String PREFS_USER_REFRESH_TOKEN = "prefs.user.refresh_token";
  static const String PREFS_USER_ID_TOKEN = "prefs.user.id_token";
  static const String PREFS_USER_ID = "prefs.user.id";
  static const String PREFS_USER_EMAIL_VERIFICATION =
      "prefs.user.email_verification";
  static const String PREFS_USER_LOGIN = "prefs.user.login";
  static const String PREFS_ACCESS_TOKEN = "prefs.user.access_token";

  FireBaseRepository _fireBaseRepository;
  AppLocalizations _appLocalizations;
  EncriptUseCase _encriptUseCase;

  MangaUserUseCase(this._fireBaseRepository, this._appLocalizations,
      this._encriptUseCase);

  MangaUser currentUser = AnonymousMangaUser();

  Future<MangaUser> get initMangaUser async {
    var prefs = await SharedPreferences.getInstance();
    var idToken = prefs.getStringSafelly(PREFS_USER_ID_TOKEN);
    var localId = prefs.getStringSafelly(PREFS_USER_ID);
    var refreshToken = prefs.getStringSafelly(PREFS_USER_REFRESH_TOKEN);

    var isEmailVerification =
    await SharedPreferencesUtil.getBool(PREFS_USER_EMAIL_VERIFICATION);
    currentUser = idToken == null || !isEmailVerification
        ? AnonymousMangaUser()
        : AuthMangaUser(isEmailVerification, idToken, localId, refreshToken);
    logger.d(currentUser);
    return currentUser;
  }

  Future<MangaUser> auth(String email, String password) async {
    var response = await _fireBaseRepository.auth(email, password);
    logger.d(response.toString());
    var accessToken = _encriptUseCase.encript(password);
    await updateUserPrefs(response.refreshToken, response.idToken,
        response.localId, email, accessToken);
    return initMangaUser;
  }

  Future<MangaUser> refreshIdToken() async {
    var prefs = await SharedPreferences.getInstance();
    var login = prefs.getStringSafelly(PREFS_USER_LOGIN);
    var accessToken = prefs.getStringSafelly(PREFS_ACCESS_TOKEN);
    return auth(login, _encriptUseCase.decript(accessToken));
  }

  Future<void> emailVerification() async {
    var idToken = await SharedPreferencesUtil.getString(PREFS_USER_ID_TOKEN);
    await _fireBaseRepository.emailVerification(
        idToken, _appLocalizations.languageCode);
  }

  Future<MangaUser> registration(String email, String password) async {
    var response = await _fireBaseRepository.registration(email, password);
    logger.d(response.toString());
    var accessToken = _encriptUseCase.encript(password);
    await updateUserPrefs(response.refreshToken, response.idToken,
        response.localId, email, accessToken);
    return initMangaUser;
  }

  Future<MangaUser> loadUserData() async {
    var idToken = await SharedPreferencesUtil.getString(PREFS_USER_ID_TOKEN);
    if (idToken == null) {
      return initMangaUser;
    }
    return _fireBaseRepository
        .getUserData(idToken)
        .then((userResponse) => setEmailVerified(userResponse))
        .then((_) => initMangaUser)
        .catchError((error, stackTrace) => _handleError(error, stackTrace));
  }

  Future<MangaUser> _handleError(dynamic error, StackTrace stackTrace) async {
    var refreshToken = await SharedPreferencesUtil.getString(PREFS_USER_REFRESH_TOKEN);
    if (refreshToken == null && error.statusCode == 400) {
      logger.e("error", error, stackTrace);
      logout();
      return initMangaUser;
    } else if (error.statusCode == 401 || error.statusCode == 400) {
      return refreshIdToken()
          .then((user) => _fireBaseRepository.getUserData(user.firebaseIdToken))
          .then((userResponse) => setEmailVerified(userResponse))
          .then((_) => initMangaUser)
          .catchError((error, stackTrace) {
        logger.e("error", error, stackTrace);
        logout();
        return initMangaUser;
      });
    } else {
      return initMangaUser;
    }
  }

  Future<void> setEmailVerified(FirebaseUserResponse response) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        PREFS_USER_EMAIL_VERIFICATION, response.emailVerified);
  }

  Future<void> logout() async {
    currentUser = AnonymousMangaUser();
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(PREFS_USER_REFRESH_TOKEN);
    await prefs.remove(PREFS_USER_ID_TOKEN);
    await prefs.remove(PREFS_USER_EMAIL_VERIFICATION);
    await prefs.remove(PREFS_ACCESS_TOKEN);
    await prefs.remove(PREFS_USER_LOGIN);
  }

  Future<void> updateUserPrefs(String refreshToken, String idToken,
      String localId, String login, String accessToken) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREFS_USER_REFRESH_TOKEN, refreshToken);
    await prefs.setString(PREFS_USER_ID_TOKEN, idToken);
    await prefs.setString(PREFS_USER_ID, localId);
    await prefs.setString(PREFS_USER_ID, localId);
    await prefs.setString(PREFS_ACCESS_TOKEN, accessToken);
    await prefs.setString(PREFS_USER_LOGIN, login);
  }
}
