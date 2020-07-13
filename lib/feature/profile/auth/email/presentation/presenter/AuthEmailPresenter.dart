import 'package:manga/core/exception/ErrorHandler.dart';
import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/firebase/use_case/FirebaseDatabaseUseCase.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailState.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailView.dart';
import 'package:manga/feature/profile/personal/domain/model/MangaUser.dart';
import 'package:manga/feature/profile/personal/domain/use_case/MangaUserUseCase.dart';
import 'package:manga/main.dart';
import 'package:manga/route/route.dart';

class AuthEmailPresenter extends BasePresenter<AuthEmailView> {
  var _mangaUserUseCase = MyApp.injector.get<MangaUserUseCase>();
  var _firebaseDatabaseUseCase = MyApp.injector.get<FirebaseDatabaseUseCase>();

  var state = AuthEmailState();

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

    await _mangaUserUseCase
        .auth(_email, _password)
        .then((_) => _mangaUserUseCase.loadUserData())
        .then((_) =>
            _firebaseDatabaseUseCase.syncData().then((value) => _mangaUserUseCase.currentUser))
        .then(handleAuthResponse)
        .catchError(handleRegistrationError);

    view.bindState(state.bind(isLoading: false));
  }

  void handleAuthResponse(MangaUser user) {
    if (!user.isVerified) {
      view.showVerifyDialog(appLocalizations.authEmailScreenEnterErrorValidation);
    } else {
      view.goBackSuccess();
    }
    logger.d(user.toString());
  }

  void handleRegistrationError(dynamic error, StackTrace stackTrace) {
    var message =
        ErrorHandler.getErrorMessage(error, stackTrace, defaultMessage: "Ошибка авторизации");
    view.showErrorDialog(message);
  }

  void onRegistrationClicked() async {
    var email = await MangaNavigator.openRegistrationScreen();
    logger.d("back email: $email");
    if (email is String) {
      view.bindState(state.bind(email: email));
    }
  }

  void resendCode() async {
    view.bindState(state.bind(isLoading: true));

    await _mangaUserUseCase
        .emailVerification()
        .then((value) => view.showTextDialog(appLocalizations.authEmailScreenValidateYourEmail))
        .catchError(handleResendCodeError);

    view.bindState(state.bind(isLoading: false));
  }

  void handleResendCodeError(dynamic error, StackTrace stackTrace) {
    var message = ErrorHandler.getErrorMessage(error, stackTrace);
    view.showErrorDialog(message);
  }
}
