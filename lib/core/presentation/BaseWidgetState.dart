import 'package:flutter/material.dart';
import 'package:manga/core/presentation/BasePresenter.dart';
import 'package:manga/core/state/BaseState.dart';
import 'package:manga/core/presentation/BaseView.dart';
import 'package:manga/core/state/ErrorState.dart';
import 'package:manga/core/state/LoadingState.dart';

abstract class BaseWidgetState<T extends StatefulWidget,
    P extends BasePresenter> extends State<T> {
  P presenter;

  BaseWidgetState(this.presenter);

  BaseState screenState;

  @override
  void bindState(BaseState state) => setState(() => screenState = state);

  @override
  void initState() {
    presenter.bindView(this as BaseView);
    super.initState();
    presenter.initState();
  }

  @override
  void deactivate() {
    presenter.deactivated();
    super.deactivate();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  Widget buildWidgetFromState() {
    var state = screenState;
    return getWidgetForState(state);
  }

  Widget getWidgetForState(BaseState state) {
    if (state is LoadingState) {
      return Container(
          alignment: Alignment.center, child: CircularProgressIndicator());
    } else if (state is ErrorState) {
      return Container(
        alignment: Alignment.center,
        child: Text(state.message),
      );
    } else return Container(color: Colors.white,);
  }
}
