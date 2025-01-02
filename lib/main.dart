import 'package:calculadora_de_carbohidratos/login/login_screen.dart';
import 'package:calculadora_de_carbohidratos/provider/locale_provider.dart';
import 'package:calculadora_de_carbohidratos/provider/user_provider.dart';
import 'package:calculadora_de_carbohidratos/services/localization_service.dart';
import 'package:calculadora_de_carbohidratos/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Asegúrate de que los servicios de Flutter están inicializados
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Cargar todos los idiomas necesarios al inicio
  await LocalizationService.loadAllLanguages(
      ['en', 'es']); // Añade los idiomas necesarios

  // Ejecuta la aplicación después de cargar los idiomas
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      theme: themeNotifier.currentTheme,
      localizationsDelegates: const [
        LocalizationService.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''), // Español
        Locale('en', ''), // Inglés
      ],
      locale: localeProvider.locale, // Usa el locale actual del LocaleProvider
      home: LoginScreen(),
    );
  }
}
