import 'package:manga/core/presentation/BaseView.dart';

abstract class AuthEmailView implements BaseView {
  void showTextDialog(String text);
  void showVerifyDialog(String text);
  void goBackSuccess();
}