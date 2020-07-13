import 'dart:convert';

import 'package:firebase/firebase_io.dart';
import 'package:manga/core/exception/ErrorHandler.dart';
import 'package:manga/core/exception/exceptions.dart';
import 'package:manga/feature/profile/personal/domain/use_case/MangaUserUseCase.dart';
import 'package:manga/main.dart';

class MangaFirebseClient extends FirebaseClient {
  MangaUserUseCase _mangaUserUseCase;

  MangaFirebseClient(this._mangaUserUseCase) : super(null);

  @override
  Future<dynamic> send(String method, url, {json}) {
    _logRequest(method, url, json);
    return super
        .send(method, url, json: json)
        .then((value) => _logResponse(value))
        .catchError((error, stack) {
      return handleError(error, stack)
          .then((_) => super.send(method, url, json: json).then((value) => _logResponse(value)));
    });
  }

  Future<dynamic> handleError(dynamic error, StackTrace stackTrace) {
    if (error is FirebaseClientException) {
      if (error.message.contains("Permission denied")) {
        return _buildException(error, stackTrace);
      } else if (error.statusCode == 401 &&
          _mangaUserUseCase.currentUser.firebaseRefreshToken != null) {
        return _mangaUserUseCase.refreshIdToken();
      }
    }

    return _buildException(error, stackTrace);
  }

  Future<Exception> _buildException(dynamic error, StackTrace stackTrace) {
    var errorMessage = ErrorHandler.getErrorMessage(error, stackTrace);
    return Future.error(AppException(errorMessage));
  }

  void _logRequest(String method, url, json) {
    var jsonString = json == null ? "" : "\n\n${jsonEncode(json)}";
    logger.d("$method: $url$jsonString");
  }

  dynamic _logResponse(body) {
    logger.d(body);
    return body;
  }
}
