import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/di/ModuleContainer.dart';
import 'package:manga/feature/profile/auth/main/presentation/presenter/AuthPresenter.dart';
import 'package:manga/feature/profile/auth/main/presentation/view/AuthState.dart';
import 'package:manga/feature/profile/auth/main/presentation/view/AuthView.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState(AuthPresenter());
}

class _AuthScreenState extends BaseWidgetState<AuthScreen, AuthPresenter> implements AuthView {
  _AuthScreenState(AuthPresenter presenter) : super(presenter);

  @override
  Widget build(BuildContext context) {
    return _wrapWithAppBar(buildWidgetFromState());
  }

  @override
  Widget buildWidgetFromState() {
    var state = screenState;
    if (state is AuthState) {
      return _buildButtonsScreen();
    } else {
      return super.buildWidgetFromState();
    }
  }

  Widget _buildButtonsScreen() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
                onPressed: presenter.onEmailButtonClicked,
                icon: Icon(Icons.mail),
                label: Text(appLocalizations.authEmailScreenEmail)),
//          RaisedButton.icon(onPressed: presenter.setPhoneView, icon: Icon(Icons.phone_android), label: Text(appLocalizations.authScreenPhone))
          ],
        ),
      ),
    );
  }

  Widget _wrapWithAppBar(Widget widget) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(appLocalizations.authScreenTitle),
      ),
      body: widget,
    );
  }

}
