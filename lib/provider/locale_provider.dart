import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('es', '');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!['es', 'en'].contains(locale.languageCode)) {
      return; // Verificar si el idioma está soportado
    }
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('es', ''); // Volver al idioma predeterminado
    notifyListeners();
  }
}
