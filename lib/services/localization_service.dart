import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LocalizationService {
  final Locale locale;

  LocalizationService(this.locale);

  static LocalizationService of(BuildContext context) {
    return Localizations.of<LocalizationService>(
            context, LocalizationService) ??
        LocalizationService(const Locale('en'));
  }

  Map<String, String>? _localizedStrings;

  // Mapa para almacenar todas las traducciones cargadas
  static final Map<String, Map<String, String>> _allTranslations = {};

  /// Método para cargar todos los idiomas al inicio de la aplicación
  static Future<void> loadAllLanguages(List<String> languages) async {
    for (String languageCode in languages) {
      String jsonString =
          await rootBundle.loadString('lib/languages/$languageCode.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Guarda el idioma en el mapa de _allTranslations
      _allTranslations[languageCode] =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }
  }

  Future<bool> load() async {
    _localizedStrings = _allTranslations[locale.languageCode];
    return _localizedStrings != null;
  }

  String translate(String key,
      [String? param, bool? firstLetterIsLowercase = false]) {
    // Obtén el texto traducido usando la clave
    String? translation = _localizedStrings?[key];

    if (translation != null && param != null && param.isNotEmpty) {
      String? translationParam =
          _localizedStrings?[param] ?? 'Translation not available';
      translation = translation.replaceAll('{parameter}', translationParam);
    }

    if (translation != null && firstLetterIsLowercase == false) {
      int index = 0;
      while (index < translation.length &&
          !RegExp(r'[a-zA-Z]').hasMatch(translation[index])) {
        index++;
      }
      if (index >= translation.length) return translation;

      return translation.substring(0, index) +
          translation[index].toUpperCase() +
          translation.substring(index + 1);
    }

    return translation ?? 'Translation not available';
  }

  /// Método síncrono para traducir una sola palabra en un idioma específico
  String translateSingleWord(String key, String languageCode) {
    Map<String, String>? translations = _allTranslations[languageCode];
    if (translations == null) {
      return 'Translation not available';
    }
    return translations[key] ?? 'Translation not available';
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
