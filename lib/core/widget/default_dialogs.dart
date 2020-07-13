import 'package:flutter/material.dart';

class Dialogs {

  static void showErrorDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Error"),
            content: Text(text),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
    );
  }

  static void showTextDialog(BuildContext context, String text, {Function okAction}) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            content: Text(text),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                  okAction?.call();
                },
              )
            ],
          ),
    );
  }

}