import 'package:firebase/firebase.dart';
import 'package:manga/feature/profile/personal/domain/model/MangaUser.dart';

class MangaUserUseCase {

  User _firebaseUser;

  Auth _firebaseAuth;

  MangaUser get mangaUser => MangaUser(_firebaseUser);

  MangaUserUseCase(this._firebaseAuth) {
    _firebaseUser = _firebaseAuth.currentUser;
  }

}