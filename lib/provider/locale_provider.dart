import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', '');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!['en', 'es'].contains(locale.languageCode)) {
      return; // Verificar si el idioma está soportado
    }
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en', ''); // Volver al idioma predeterminado
    notifyListeners();
  }
}
