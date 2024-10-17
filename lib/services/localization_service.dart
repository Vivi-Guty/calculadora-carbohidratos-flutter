import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LocalizationService {
  final Locale locale;

  LocalizationService(this.locale);

  static LocalizationService? of(BuildContext context) {
    return Localizations.of<LocalizationService>(context, LocalizationService);
  }

  Map<String, String>? _localizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('lib/languages/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String? translate(String key) {
    return _localizedStrings?[key];
  }

  static const LocalizationsDelegate<LocalizationService> delegate =
      _LocalizationServiceDelegate();
}

class _LocalizationServiceDelegate
    extends LocalizationsDelegate<LocalizationService> {
  const _LocalizationServiceDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<LocalizationService> load(Locale locale) async {
    LocalizationService localization = LocalizationService(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_LocalizationServiceDelegate old) => false;
}
