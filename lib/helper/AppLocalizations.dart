import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizations {
  static AppLocalizations? _instance;

  static Future<AppLocalizations> load(Locale locale) async {
    String name = locale.languageCode;
    if (locale.countryCode == null || locale.countryCode!.isEmpty) {
      name = locale.toString();
    }
    final String localeName = Intl.canonicalizedLocale(name);
    final String path = 'assets/i18n/$localeName.arb';
    final String jsonString = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final AppLocalizations localizations = AppLocalizations._(jsonMap);
    _instance = localizations;
    return localizations;
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final Map<String, dynamic> _localizedStrings;

  AppLocalizations._(this._localizedStrings);

  String translate(String key) {
    return _localizedStrings[key] ?? '';
  }
}