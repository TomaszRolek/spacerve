// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Rezerwuj swoją przestrzeń w wygodny sposób.`
  String get welcome_desc {
    return Intl.message(
      'Rezerwuj swoją przestrzeń w wygodny sposób.',
      name: 'welcome_desc',
      desc: '',
      args: [],
    );
  }

  /// `Zaloguj się`
  String get login {
    return Intl.message(
      'Zaloguj się',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Zarejestruj się`
  String get register {
    return Intl.message(
      'Zarejestruj się',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// ` Nie posiadasz jeszcze konta? `
  String get do_not_have_account {
    return Intl.message(
      ' Nie posiadasz jeszcze konta? ',
      name: 'do_not_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Wystąpił błąd`
  String get error_occurred {
    return Intl.message(
      'Wystąpił błąd',
      name: 'error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Pole nie może zostać puste`
  String get cant_be_empty {
    return Intl.message(
      'Pole nie może zostać puste',
      name: 'cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Hasło`
  String get password {
    return Intl.message(
      'Hasło',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Podano nieprawidłowy email`
  String get invalid_email {
    return Intl.message(
      'Podano nieprawidłowy email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Hasło musi zawierać conajmniej 8 znaków`
  String get invalid_pass {
    return Intl.message(
      'Hasło musi zawierać conajmniej 8 znaków',
      name: 'invalid_pass',
      desc: '',
      args: [],
    );
  }

  /// `Podano nieprawidłowe dane`
  String get login_error {
    return Intl.message(
      'Podano nieprawidłowe dane',
      name: 'login_error',
      desc: '',
      args: [],
    );
  }

  /// `Wystąpił błąd podczas rejestracji`
  String get register_error {
    return Intl.message(
      'Wystąpił błąd podczas rejestracji',
      name: 'register_error',
      desc: '',
      args: [],
    );
  }

  /// `Rezerwuj`
  String get reserve {
    return Intl.message(
      'Rezerwuj',
      name: 'reserve',
      desc: '',
      args: [],
    );
  }

  /// `Twoje rezerwacje`
  String get your_reservations {
    return Intl.message(
      'Twoje rezerwacje',
      name: 'your_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Skanuj`
  String get scan {
    return Intl.message(
      'Skanuj',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Wyloguj się`
  String get logout {
    return Intl.message(
      'Wyloguj się',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Sale`
  String get rooms {
    return Intl.message(
      'Sale',
      name: 'rooms',
      desc: '',
      args: [],
    );
  }

  /// `Dostępne sale`
  String get free_rooms {
    return Intl.message(
      'Dostępne sale',
      name: 'free_rooms',
      desc: '',
      args: [],
    );
  }

  /// `Rezerwacje`
  String get reservations {
    return Intl.message(
      'Rezerwacje',
      name: 'reservations',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pl', countryCode: 'PL'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
