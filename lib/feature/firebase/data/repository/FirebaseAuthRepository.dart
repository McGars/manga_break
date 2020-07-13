
import 'package:firebase/firebase_io.dart';
import 'package:manga/feature/firebase/data/model/Auth.dart';
import 'package:manga/feature/firebase/data/model/EmailVerification.dart';
import 'package:manga/feature/firebase/data/model/FirebaseUser.dart';
import 'package:manga/feature/firebase/data/model/RefreshToken.dart';
import 'package:manga/feature/firebase/data/model/Registration.dart';
import 'package:manga/feature/firebase/data/repository/FirebaseAuthApi.dart';
import 'package:manga/main.dart';

class FireBaseRepository {

  FirebaseClient _firebaseClient;

  FireBaseRepository(this._firebaseClient);

  Future<RegistrationResponse> registration(String email, String password) async {
    var uri = FirebaseAuthApi.getRegistraionUri();
    var response = await _firebaseClient.post(uri, RegistrationRequest(email, password));
    return RegistrationResponse.fromJson(response);
  }

  Future<AuthResponse> auth(String email, String password) async {
    var uri = FirebaseAuthApi.getAuthUri();
    var response = await _firebaseClient.post(uri, AuthRequest(email, password));
    return AuthResponse.fromJson(response);
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    var uri = FirebaseAuthApi.getRefreshTokenUri();
    var response = await _firebaseClient.post(uri, RefreshTokenRequest(refreshToken));
    return AuthResponse.fromJson(response);
  }

  Future<AuthResponse> emailVerification(String idToken, String languageCode) async {
    var uri = FirebaseAuthApi.getVerifyEmailUri();
    var response = await _firebaseClient.post(uri, EmailRequest(idToken, languageCode));
    logger.d(response.toString());
    return AuthResponse.fromJson(response);
  }

  Future<FirebaseUserResponse> getUserData(String idToken) async {
    var uri = FirebaseAuthApi.getUserData();
    var response = await _firebaseClient.post(uri, FirebaseUserRequest(idToken));
    logger.d(response.toString());
    var users = response["users"];
    // TODO if the regisration will be besides by password, need handle it
    return FirebaseUserResponse.fromJson(users.first);
  }


}