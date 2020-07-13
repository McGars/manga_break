//import 'package:firebase/firebase.dart';

class MangaUser {

//  bool get isAuthorize => _fireBaseUser != null;
  bool get isAuthorize => false;
  bool get isVerified => false;
  String get firebaseIdToken => "";
  String get firebaseLocalId => "";
  String get firebaseRefreshToken => null;
}

class AuthMangaUser implements MangaUser {

  var _emailVerified;
  var _firebaseIdToken;
  var _firebaseLocalId;
  var _firebaseRefreshToken;

  AuthMangaUser(this._emailVerified, this._firebaseIdToken, this._firebaseLocalId, this._firebaseRefreshToken);

  @override
  bool get isAuthorize => true;

  @override
  bool get isVerified => _emailVerified;

  @override
  String get firebaseIdToken => _firebaseIdToken;

  @override
  String get firebaseLocalId => _firebaseLocalId;

  @override
  String get firebaseRefreshToken => _firebaseRefreshToken;

}

class AnonymousMangaUser extends MangaUser {}