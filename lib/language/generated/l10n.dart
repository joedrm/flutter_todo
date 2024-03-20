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

  /// `Tab Pages`
  String get nav_tab {
    return Intl.message(
      'Tab Pages',
      name: 'nav_tab',
      desc: '',
      args: [],
    );
  }

  /// `News List`
  String get nav_news {
    return Intl.message(
      'News List',
      name: 'nav_news',
      desc: '',
      args: [],
    );
  }

  /// `Route Navigation And Parameter Transfer`
  String get nav_route {
    return Intl.message(
      'Route Navigation And Parameter Transfer',
      name: 'nav_route',
      desc: '',
      args: [],
    );
  }

  /// `Use Completer And Compute in Flutter`
  String get nav_completer {
    return Intl.message(
      'Use Completer And Compute in Flutter',
      name: 'nav_completer',
      desc: '',
      args: [],
    );
  }

  /// `Chrome Extension`
  String get nav_extension {
    return Intl.message(
      'Chrome Extension',
      name: 'nav_extension',
      desc: '',
      args: [],
    );
  }

  /// `Intl`
  String get nav_intl {
    return Intl.message(
      'Intl',
      name: 'nav_intl',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get tab_home {
    return Intl.message(
      'Home',
      name: 'tab_home',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get tab_search {
    return Intl.message(
      'Search',
      name: 'tab_search',
      desc: '',
      args: [],
    );
  }

  /// `Favor`
  String get tab_favor {
    return Intl.message(
      'Favor',
      name: 'tab_favor',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get tab_setting {
    return Intl.message(
      'Setting',
      name: 'tab_setting',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get intl_zh {
    return Intl.message(
      'Chinese',
      name: 'intl_zh',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get intl_en {
    return Intl.message(
      'English',
      name: 'intl_en',
      desc: '',
      args: [],
    );
  }

  /// `This is a alert`
  String get alert_msg {
    return Intl.message(
      'This is a alert',
      name: 'alert_msg',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
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
