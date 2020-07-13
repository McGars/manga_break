import 'package:manga/core/state/BaseState.dart';

class AuthRegistrationState implements BaseState {

  bool isLoading = false;

  AuthRegistrationState();

  AuthRegistrationState bind({bool isLoading}) {
    this.isLoading = isLoading ?? this.isLoading;
    return this;
  }

}
