import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/core/widget/ModalLoadingWidget.dart';
import 'package:manga/core/widget/default_dialogs.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/profile/auth/email/util/validator.dart';
import 'package:manga/feature/profile/auth/registration/presentation/presenter/AuthRegistrationPresenter.dart';
import 'package:manga/feature/profile/auth/registration/presentation/view/AuthRegistrationState.dart';
import 'package:manga/feature/profile/auth/registration/presentation/view/AuthRegistrationView.dart';

class AuthRegistrationScreen extends StatefulWidget {
  @override
  _AuthRegistrationScreenState createState() =>
      _AuthRegistrationScreenState(AuthRegistrationPresenter());
}

class _AuthRegistrationScreenState
    extends BaseWidgetState<AuthRegistrationScreen, AuthRegistrationPresenter>
    implements AuthRegistrationView {
  _AuthRegistrationScreenState(AuthRegistrationPresenter presenter)
      : super(presenter);

  final _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  var _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return buildWidgetFromState();
  }

  @override
  Widget buildWidgetFromState() {
    var state = screenState;
    if (state is AuthRegistrationState) {
      return _wrapWithAppBar(_buildScreen(state));
    } else {
      return _wrapWithAppBar(super.buildWidgetFromState());
    }
  }

  @override
  void showErrorDialog(String text) {
    Dialogs.showErrorDialog(context, text);
  }

  @override
  void showVerificationEmailDialog() {
    Dialogs.showTextDialog(
        context,
        appLocalizations.authRegistrationScreenVerifyEmail,
        okAction: presenter.onVerificationOkButtonClicked
    );
  }

  Widget _buildScreen(AuthRegistrationState state) {
    var screen = [_buildEmailScreen()];

    if (state.isLoading) {
      screen.add(ModalLoadingWidget());
    }

    return Stack(
      children: screen,
    );
  }

  Widget _buildEmailScreen() {
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
              decoration: InputDecoration(
                hintText: appLocalizations.authEmailScreenEnterEmail,
              ),
              validator: emailValidator,
              keyboardType: TextInputType.emailAddress,
              onSaved: presenter.onEmailSave,
            ),
            TextFormField(
              key: passKey,
              decoration: InputDecoration(
                hintText: appLocalizations.authEmailScreenEnterPassword,
              ),
              obscureText: true,
              validator: passwordValidator,
              onSaved: presenter.onPasswordSave,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: appLocalizations.authRegistrationScreenRepeatPassword,
              ),
              obscureText: true,
              validator: (confirmation) {
                String password = passKey.currentState.value;
                return confirmation.trim() == password.trim()
                    ? null
                    : appLocalizations.authRegistrationScreenRepeatError;
              },
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
                          FocusScope.of(context).unfocus();
                          _formKey.currentState.save();
                          presenter.onButtonClicked();
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
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
        title: new Text(appLocalizations.authScreenRegister),
      ),
      body: widget,
    );
  }
}
