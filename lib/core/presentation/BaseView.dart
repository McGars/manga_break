
import 'package:manga/core/state/BaseState.dart';

abstract class BaseView {

  void bindState(BaseState state);

  void showErrorDialog(String text);


}