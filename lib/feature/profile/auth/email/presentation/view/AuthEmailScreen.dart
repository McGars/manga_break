import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/profile/auth/email/presentation/presenter/AuthEmailPresenter.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailState.dart';
import 'package:manga/feature/profile/auth/email/presentation/view/AuthEmailView.dart';

class AuthEmailScreen extends StatefulWidget {
  @override
  _AuthEmailScreenState createState() =>
      _AuthEmailScreenState(AuthEmailPresenter());
}

class _AuthEmailScreenState
    extends BaseWidgetState<AuthEmailScreen, AuthEmailPresenter>
    implements AuthEmailView {
  _AuthEmailScreenState(AuthEmailPresenter presenter) : super(presenter);

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

  Widget _buildScreen(AuthEmailState state) {
    return _buildEmailScreen();
  }

  Widget _buildEmailScreen() {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: appLocalizations.authEmailScreenEnterEmail,
              ),
              validator: _emailValidator,
              keyboardType: TextInputType.emailAddress,
              onSaved: presenter.onEmailSave,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: appLocalizations.authEmailScreenEnterPassword,
              ),
              validator: _passwordValidator,
              onSaved: presenter.onPasswordSave,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                child: Text('Submit'),
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

  String _passwordValidator(String value) {
    if (value.isEmpty) {
      return appLocalizations.errorEmpty;
    }
    return null;
  }

  String _emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return appLocalizations.authEmailScreenEnterValidEmail;
    else
      return null;
  }
}
