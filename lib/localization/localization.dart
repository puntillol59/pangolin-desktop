import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Localization {
  final Locale locale;

  Localization(this.locale);

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Map<String, String> _localizationValues;

  Future load() async {
    String jsonStringValues = await rootBundle.loadString(
        "lib/localization/languages/${locale.languageCode}-${locale.countryCode}.json");

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizationValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String get(String key) {
    if (_localizationValues[key] == null) {
      return "Error";
    } else {
      return _localizationValues[key];
    }
  }

  static const LocalizationsDelegate<Localization> delegate =
      _LocalizationDelegate();
}

class _LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const _LocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "de", "fr", "pl", "hr", "nl"].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    Localization localization = new Localization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate old) => false;
}