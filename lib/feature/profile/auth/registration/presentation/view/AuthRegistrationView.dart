
import 'package:manga/core/presentation/BaseView.dart';

abstract class AuthRegistrationView implements BaseView {
  void showErrorDialog(String text);

  void showVerificationEmailDialog();

}