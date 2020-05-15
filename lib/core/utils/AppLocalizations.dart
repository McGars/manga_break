import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {

  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Common
  String get ofTest => _text('of');
  String get loading => _text('loading');

  // Error
  String get errorUiDefault => _text('errorUiDefault');
  String get errorEmpty => _text('errorEmpty');

  // Auth screen
  String get authScreenTitle => _text('authScreenTitle');
  
  // Auth email screen
  String get authEmailScreenEmail => _text('authEmailScreenEmail');
  String get authEmailScreenEnterEmail => _text('authEmailScreenEnterEmail');
  String get authEmailScreenEnterPassword => _text('authEmailScreenEnterPassword');
  String get authEmailScreenEnterValidEmail => _text('authEmailScreenEnterValidEmail');

  // Manga details screen
  String get detailsScreenEmptyChapters => _text('detailsScreenEmptyChapters');
  String get detailsScreenChaptersSubTitle => _text('detailsScreenChaptersSubTitle');

  // Library screen
  String get libraryScreenTitle => _text('libraryScreenTitle');
  String get libraryScreenSearchData => _text('libraryScreenSearchData');



  static Map<String, Map<String, String>> _localizedValues = {
    'ru': {

      // common
      'of': "из",
      'loading': "Загрузка",

      // errors
      'errorUiDefault': "Ошибка. Попробуйте позже",
      'errorEmpty': "Поле не должно быть пустым",

      // Auth screen
      'authScreenTitle': "Авторизация",
      'authEmailScreenEmail': "Авторизация",
      'authEmailScreenEnterEmail': "Введите электронную почту",
      'authEmailScreenEnterPassword': "Введите пароль",
      'authEmailScreenEnterValidEmail': "Неверный формат почты",

      // Details screen
      'detailsScreenEmptyChapters': "Главы отсутствуют",
      'detailsScreenChaptersSubTitle': "Главы",

      // Library screen
      'libraryScreenTitle': 'Библиотека',
      'libraryScreenSearchData': 'Поиск манги...',
    },

    'en': {
      // common
      'of': "of",
      'loading': "loading",

      // errors
      'errorUiDefault': "Error. Please try later",
      'errorEmpty': "Please enter some text",

      // Auth screen
      'authScreenTitle': "Auth",
      'authEmailScreenEmail': "Auth by Email",
      'authEmailScreenEnterEmail': "Enter your email",
      'authEmailScreenEnterPassword': "Enter your password",
      'authEmailScreenEnterValidEmail': "Enter Valid Email",

      // Details screen
      'detailsScreenEmptyChapters': "No chapters",
      'detailsScreenChaptersSubTitle': "Chapters",

      // Library screen
      'libraryScreenTitle': 'Library',
      'libraryScreenSearchData': 'Search manga...',
    },
  };

  String _text(String key) =>  _localizedValues[locale.languageCode][key];

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}