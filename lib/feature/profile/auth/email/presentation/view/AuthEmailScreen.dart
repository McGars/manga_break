import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/core/widget/ModalLoadingWidget.dart';
import 'package:manga/core/widget/default_dialogs.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/profile/auth/email/presentation/presenter/AuthEmailPresenter.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailState.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailView.dart';
import 'package:manga/feature/profile/auth/email/util/validator.dart';

class AuthEmailScreen extends StatefulWidget {

  @override
  _AuthEmailScreenState createState() =>
      _AuthEmailScreenState(AuthEmailPresenter());
}

class _AuthEmailScreenState
    extends BaseWidgetState<AuthEmailScreen, AuthEmailPresenter>
    implements AuthEmailView {
  _AuthEmailScreenState(AuthEmailPresenter presenter) : super(presenter);

  final TextEditingController loginController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return buildWidgetFromState();
  }

  @override
  Widget buildWidgetFromState() {
    var state = screenState;
    if (state is AuthEmailState) {
      return _wrapWithAppBar(_buildScreen(state));
    } else {
      return _wrapWithAppBar(super.buildWidgetFromState());
    }
  }

  @override
  void showTextDialog(String text) {
    Dialogs.showTextDialog(context, text);
  }

  @override
  void showVerifyDialog(String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(text),
        actions: [
          FlatButton(
            child: Text(appLocalizations.cancel),
            onPressed:  () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text(appLocalizations.authEmailScreenResendCode),
            onPressed:  () {
              Navigator.pop(context);
              presenter.resendCode();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScreen(AuthEmailState state) {

    loginController.text = state.email;

    var screen = [_buildEmailScreen(state)];

    if (state.isLoading) {
      screen.add(ModalLoadingWidget());
    }

    return Stack(
      children: screen,
    );
  }

  Widget _buildEmailScreen(AuthEmailState state) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: loginController,
              decoration: InputDecoration(
                hintText: appLocalizations.authEmailScreenEnterEmail,
              ),
              validator: emailValidator,
              keyboardType: TextInputType.emailAddress,
              onSaved: presenter.onEmailSave,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: appLocalizations.authEmailScreenEnterPassword,
              ),
              obscureText: true,
              validator: passwordValidator,
              onSaved: presenter.onPasswordSave,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: RaisedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          presenter.onButtonClicked();
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
                      child: Text(appLocalizations.authEmailScreenSignIn),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: OutlineButton(
                      textColor: Colors.black,
                      onPressed: presenter.onRegistrationClicked,
                      child: Text(appLocalizations.authScreenRegister),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wrapWithAppBar(Widget widget) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(appLocalizations.authEmailScreenEmail),
      ),
      body: widget,
    );
  }

  @override
  void goBackSuccess() {
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    super.dispose();
    loginController.dispose();
  }

}
