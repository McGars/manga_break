
import 'package:manga/core/state/BaseState.dart';

class ErrorState implements BaseState {

  String message;

  ErrorState(this.message);

}