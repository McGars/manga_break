import 'package:manga/di/ModuleContainer.dart';

String passwordValidator(String value) {
  var text = value.trim();
  return text.isEmpty ? appLocalizations.errorEmpty : null;
}

String emailValidator(String value) {
  var text = value.trim();
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(text) ? null : appLocalizations.authEmailScreenEnterValidEmail;
}