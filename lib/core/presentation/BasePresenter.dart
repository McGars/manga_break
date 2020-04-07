import 'package:manga/core/exception/ErrorHandler.dart';
import 'package:manga/core/state/ErrorState.dart';

import 'BaseView.dart';

abstract class BasePresenter<T extends BaseView> {

  T view;

  BasePresenter();

  void bindView(T view) {
    this.view = view;
  }

  void unbindView() {
    this.view = null;
  }

  void initState() {}

  void deactivated() {}

  void dispose() {}

  void handleDefaultError(dynamic error, StackTrace stackTrace) {
    var message = ErrorHandler.getErrorMessage(error, stackTrace);
    view.bindState(ErrorState(message));
  }

}