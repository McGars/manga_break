import 'package:manga/core/state/BaseState.dart';

class AuthEmailState implements BaseState {

  bool isLoading = false;
  String email;

  AuthEmailState();

  AuthEmailState bind({bool isLoading, String email}) {
    this.isLoading = isLoading ?? this.isLoading;
    this.email = email;
    return this;
  }

}
