import 'package:manga/core/exception/ErrorHandler.dart';
import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/feature/profile/auth/registration/presentation/view/AuthRegistrationState.dart';
import 'package:manga/feature/profile/auth/registration/presentation/view/AuthRegistrationView.dart';
import 'package:manga/feature/profile/personal/domain/model/MangaUser.dart';
import 'package:manga/feature/profile/personal/domain/use_case/MangaUserUseCase.dart';
import 'package:manga/main.dart';
import 'package:manga/route/route.dart';

class AuthRegistrationPresenter extends BasePresenter<AuthRegistrationView> {

  var mangaUserUseCase = MyApp.injector.get<MangaUserUseCase>();

  var state = AuthRegistrationState();

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    view.bindState(state);
  }

  void onEmailSave(String email) {
    _email = email.trim();
  }

  void onPasswordSave(String password) {
    _password = password.trim();
  }

  void onButtonClicked() async {
    view.bindState(state.bind(isLoading: true));

    await mangaUserUseCase
        .registration(_email, _password)
        .then(_handleRegistrationResponse)
        .then((_) => mangaUserUseCase.emailVerification())
        .then((_) => view.showVerificationEmailDialog())
        .catchError(_handleRegistrationError);

    view.bindState(state.bind(isLoading: false));
  }

  void onVerificationOkButtonClicked() {
    MangaNavigator.pop(_email);
  }

  void _handleRegistrationResponse(MangaUser user) {
    logger.d(user.toString());
  }

  void _handleRegistrationError(dynamic error, StackTrace stackTrace) {
    var message = ErrorHandler.getErrorMessage(error, stackTrace, defaultMessage: "Ошибка авторизации");
    view.showErrorDialog(message);
  }

}
