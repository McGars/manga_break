import 'package:firebase/firebase_io.dart';
import 'package:manga/core/exception/FirebaseErrorHandler.dart';
import 'package:manga/core/exception/exceptions.dart';
import 'package:manga/core/utils/AppLocalizations.dart';
import 'package:manga/main.dart';

class ErrorHandler {

  static String getErrorMessage(dynamic error, StackTrace stackTrace, {String defaultMessage}) {
    var message;

    if (error is AppException) message = error.message;
    else if (error is FirebaseClientException) message = FirebaseErrorHandler.tryGetErrors(error.message);
    else message = defaultMessage ?? MyApp.injector.get<AppLocalizations>().errorUiDefault;

    logger.e(message, error, stackTrace);

    return message;
  }

  static void printErrorMessage(dynamic error, StackTrace stackTrace) {
    logger.e("error", error, stackTrace);
  }

}