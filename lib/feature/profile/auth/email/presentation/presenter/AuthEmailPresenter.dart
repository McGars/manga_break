import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailState.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailView.dart';

class AuthEmailPresenter extends BasePresenter<AuthEmailView> {

  var state = AuthEmailState();

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    view.bindState(state);
  }

  void onEmailSave(String email) {
    _email = email;
  }

  void onPasswordSave(String password) {
    _password = password;
  }

  void onButtonClicked() {

  }

}
