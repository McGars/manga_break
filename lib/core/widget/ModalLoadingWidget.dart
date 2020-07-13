import 'package:flutter/material.dart';

class ModalLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide keyboard
    FocusScope.of(context).unfocus();
    return new Stack(
      children: [
        new Opacity(
          opacity: 0.5,
          child: const ModalBarrier(dismissible: false, color: Colors.grey),
        ),
        new Center(
          child: new CircularProgressIndicator(),
        ),
      ],
    );
  }
}
