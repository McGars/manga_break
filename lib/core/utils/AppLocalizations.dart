import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {

  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get languageCode => locale.languageCode;

  String get countryCode => locale.countryCode;

  // Common
  String get yesTest => _text('yes');
  String get noTest => _text('no');
  String get ofTest => _text('of');
  String get loading => _text('loading');
  String get cancel => _text('cancel');
  String get empty => _text('empty');

  // Error
  String get errorUiDefault => _text('errorUiDefault');
  String get errorEmpty => _text('errorEmpty');
  String get errorConnection => _text('errorConnection');

  // Auth screen
  String get authScreenTitle => _text('authScreenTitle');
  String get authScreenRegister => _text('authScreenRegister');

  // Auth email screen
  String get authEmailScreenEmail => _text('authEmailScreenEmail');
  String get authEmailScreenSignIn => _text('authEmailScreenSignIn');
  String get authEmailScreenEnterEmail => _text('authEmailScreenEnterEmail');
  String get authEmailScreenEnterPassword => _text('authEmailScreenEnterPassword');
  String get authEmailScreenEnterValidEmail => _text('authEmailScreenEnterValidEmail');
  String get authEmailScreenValidateYourEmail => _text('authEmailScreenValidateYourEmail');
  String get authEmailScreenEnterErrorValidation => _text('authEmailScreenEnterErrorValidation');
  String get authEmailScreenResendCode => _text('authEmailScreenResendCode');

  // Auth registration screen
  String get authRegistrationScreenRepeatPassword => _text('authRegistrationScreenRepeatPassword');
  String get authRegistrationScreenRepeatError => _text('authRegistrationScreenRepeatError');
  String get authRegistrationScreenVerifyEmail => _text('authRegistrationScreenVerifyEmail');

  // Manga details screen
  String get detailsScreenEmptyChapters => _text('detailsScreenEmptyChapters');
  String get detailsScreenChaptersSubTitle => _text('detailsScreenChaptersSubTitle');

  // Library screen
  String get libraryScreenTitle => _text('libraryScreenTitle');
  String get libraryScreenTitleFavorite => _text('libraryScreenTitleFavorite');
  String get libraryScreenSearchData => _text('libraryScreenSearchData');



  static Map<String, Map<String, String>> _localizedValues = {
    'ru': {

      // common
      'of': "из",
      'yes': "Да",
      'no': "Нет",
      'loading': "Загрузка",
      'cancel': "Отмена",
      'empty': "Пока ничего нет",

      // errors
      'errorUiDefault': "Ошибка. Попробуйте позже",
      'errorEmpty': "Поле не должно быть пустым",
      'errorConnection': "Интернет не доступен",

      // Auth screen
      'authScreenTitle': "Авторизация",
      'authScreenRegister': "Регистрация",

      // Auth email screen
      'authEmailScreenEmail': "Авторизация",
      'authEmailScreenSignIn': "Войти",
      'authEmailScreenEnterEmail': "Введите электронную почту",
      'authEmailScreenEnterPassword': "Введите пароль",
      'authEmailScreenEnterValidEmail': "Неверный формат почты",
      'authEmailScreenValidateYourEmail': "Проверьте вашу почту",
      'authEmailScreenEnterErrorValidation': "Необходима активация почты, выслать повторное письмо с активацией?",
      'authEmailScreenResendCode': "Отправить",

      // Auth registration screen
      'authRegistrationScreenRepeatPassword': "Повторить пароль",
      'authRegistrationScreenRepeatError': "Пароли не совпадают",
      'authRegistrationScreenVerifyEmail': "Регистрация прошла успешно! Пройдите активацию через email",

      // Details screen
      'detailsScreenEmptyChapters': "Главы отсутствуют",
      'detailsScreenChaptersSubTitle': "Главы",

      // Library screen
      'libraryScreenTitle': 'Библиотека',
      'libraryScreenTitleFavorite': 'Избранное',
      'libraryScreenSearchData': 'Поиск манги...',
    },

    'en': {
      // common
      'of': "of",
      'yes': "yes",
      'no': "no",
      'loading': "loading",
      'cancel': "Cancel",
      'empty': "No data",

      // errors
      'errorUiDefault': "Error. Please try later",
      'errorEmpty': "Please enter some text",
      'errorConnection': "Connection not available",

      // Auth screen
      'authScreenTitle': "Auth",
      'authScreenRegister': "Sign up",

      // Auth email screen
      'authEmailScreenEmail': "Auth by Email",
      'authEmailScreenSignIn': "Sign in",
      'authEmailScreenEnterEmail': "Enter your email",
      'authEmailScreenEnterPassword': "Enter your password",
      'authEmailScreenEnterValidEmail': "Enter Valid Email",
      'authEmailScreenValidateYourEmail': "Check your email",
      'authRegistrationScreenVerifyEmail': "Please, verify your email",
      'authEmailScreenEnterErrorValidation': "Please, verify your email. Resend activation code on your email?",
      'authEmailScreenResendCode': "Re-send",

      // Auth registration screen
      'authRegistrationScreenRepeatPassword': "Confirm Password",
      'authRegistrationScreenRepeatError': "Confirm Password should match password",

      // Details screen
      'detailsScreenEmptyChapters': "No chapters",
      'detailsScreenChaptersSubTitle': "Chapters",

      // Library screen
      'libraryScreenTitle': 'Library',
      'libraryScreenTitleFavorite': 'Favorite',
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