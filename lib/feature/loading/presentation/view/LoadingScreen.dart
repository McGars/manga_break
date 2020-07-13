import 'package:flutter/material.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/feature/loading/presentation/presenter/LoadingPresenter.dart';
import 'package:manga/feature/loading/presentation/view/LoadingView.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState
    extends BaseWidgetState<LoadingScreen, LoadingPresenter>
    implements LoadingView {
  _LoadingScreenState() : super(LoadingPresenter());

  @override
  Widget build(BuildContext context) => Scaffold(body: buildWidgetFromState());
}
