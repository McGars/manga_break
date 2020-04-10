import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:manga/core/presentation/BaseWidgetState.dart';
import 'package:manga/feature/reader/data/model/ReaderParameter.dart';
import 'package:manga/feature/reader/presentation/presenter/ReaderPresenter.dart';
import 'package:manga/feature/reader/presentation/view/ReaderState.dart';
import 'package:manga/feature/reader/presentation/view/ReaderView.dart';
import 'package:flutter/services.dart';

class ReaderScreen extends StatefulWidget {
  final ReaderParameter _parameter;

  ReaderScreen(this._parameter);

  @override
  _ReaderScreenState createState() => _ReaderScreenState(_parameter);
}

class _ReaderScreenState extends BaseWidgetState<ReaderScreen, ReaderPresenter>
    with TickerProviderStateMixin implements ReaderView {


  AnimationController _animationController;

  Function animationListener;

  Animation<double> _animation;
  
  _ReaderScreenState(ReaderParameter parameter)
      : super(ReaderPresenter(parameter));


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: buildWidgetFromState());

  @override
  Widget buildWidgetFromState() {
    var state = screenState;
    return state is ReaderState
        ? _buildReader(state)
        : super.buildWidgetFromState();
  }

  Widget _buildReader(ReaderState state) {
    return ExtendedImageGesturePageView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: state.pages.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height),
            child: ExtendedImage.network(
              state.pages[index].url,
              fit: BoxFit.contain,
              //enableLoadState: false,
              mode: ExtendedImageMode.gesture,
              initGestureConfigHandler: (state) {
                return GestureConfig(
                  minScale: 1,
                  animationMinScale: 1,
                  maxScale: 3.0,
                  animationMaxScale: 3.0,
                  speed: 1.0,
                  inertialSpeed: 700.0,
                  initialScale: 1.0,
                  inPageView: true,
                  initialAlignment: InitialAlignment.center,
                );
              },
              onDoubleTap: (ExtendedImageGestureState gestureState) {
                ///you can use define pointerDownPosition as you can,
                ///default value is double tap pointer down postion.
                var pointerDownPosition = gestureState.pointerDownPosition;
                double begin = gestureState.gestureDetails.totalScale;
                double end;

                //remove old
                _animation?.removeListener(animationListener);

                //stop pre
                _animationController?.stop();

                //reset to use
                _animationController?.reset();

                if (begin == gestureState.imageGestureConfig.minScale) {
                  end = gestureState.imageGestureConfig.maxScale / 2;
                } else {
                  end = gestureState.imageGestureConfig.minScale;
                }

                animationListener = () {
                  //print(_animation.value);
                  gestureState.handleDoubleTap(
                      scale: _animation.value,
                      doubleTapPosition: pointerDownPosition,
                  );
                };

                _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

                _animation = _animationController
                    .drive(Tween<double>(begin: begin, end: end));

                _animation.addListener(animationListener);

                _animationController.forward();
              },
            ),
          ),
        );
      },
    );

  }
}
