import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/feature/profile/auth/main/presentation/view/AuthState.dart';
import 'package:manga/feature/profile/auth/main/presentation/view/AuthView.dart';
import 'package:manga/route/route.dart';

class AuthPresenter extends BasePresenter<AuthView> {
  var authState = AuthState();

  @override
  void initState() {
    super.initState();
    view.bindState(authState);
  }

  void onEmailButtonClicked() {
    MangaNavigator.openEmailScreen();
  }

  void setPhoneView() {
  }

}
