import 'package:manga/core/exception/exceptions.dart';
import 'package:manga/core/utils/AppLocalizations.dart';
import 'package:manga/main.dart';

class ErrorHandler {

  static String getErrorMessage(dynamic error, StackTrace stackTrace) {
    var message;

    if (error is AppException) message = error.message;
    else message = MyApp.injector.get<AppLocalizations>().errorUiDefault;
    logger.e(message, error, stackTrace);

    return message;
  }

}