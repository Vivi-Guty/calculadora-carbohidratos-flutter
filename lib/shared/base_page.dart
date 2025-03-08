import 'package:calculadora_de_carbohidratos/login/login_screen.dart';
import 'package:calculadora_de_carbohidratos/provider/locale_provider.dart';
import 'package:calculadora_de_carbohidratos/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_notifier.dart';
import 'app_drawer.dart';

abstract class BasePage extends StatelessWidget {
  final String title;

  const BasePage({super.key, required this.title});

  Widget pageBody();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              // Evita que el título empuje los iconos
              child: Text(
                title,
                overflow:
                    TextOverflow.ellipsis, // Corta el texto si es muy largo
                maxLines: 1, // Mantiene el título en una sola línea
              ),
            ),
            IconButton(
              onPressed: () {
                themeNotifier.toggleTheme();
              },
              icon: Icon(themeNotifier.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode),
            ),
            IconButton(
              onPressed: () {
                _showSettingsDialog(context);
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: pageBody(),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(LocalizationService.of(context).translate('logout')),
              onTap: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                _logout(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: Text(
                  LocalizationService.of(context).translate('change_password')),
              onTap: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                _changePassword(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(
                  LocalizationService.of(context).translate('change_username')),
              onTap: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                _changeUsername(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(
                  LocalizationService.of(context).translate('change_language')),
              onTap: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                _changeLanguage(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    // Aquí puedes implementar la lógica de cerrar sesión
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }

  void _changePassword(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              LocalizationService.of(context).translate('change_password')),
          content: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText:
                  LocalizationService.of(context).translate('new_password'),
            ),
            obscureText: true,
          ),
          actions: [
            TextButton(
              child: Text(LocalizationService.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(LocalizationService.of(context).translate('save')),
              onPressed: () {
                // Implementa la lógica para guardar la nueva contraseña
                // String newPassword = passwordController.text;
                // Actualiza la entidad del usuario o envía la nueva contraseña a la base de datos
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changeUsername(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              LocalizationService.of(context).translate('change_username')),
          content: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText:
                  LocalizationService.of(context).translate('new_username'),
            ),
          ),
          actions: [
            TextButton(
              child: Text(LocalizationService.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(LocalizationService.of(context).translate('save')),
              onPressed: () {
                // Implementa la lógica para guardar el nuevo nombre de usuario
                // String newUsername = usernameController.text;
                // Actualiza la entidad del usuario o envía el nuevo nombre de usuario a la base de datos
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage(BuildContext context) {
    final List<Locale> supportedLocales = [
      const Locale('en', ''), // Inglés
      const Locale('es', ''), // Español
    ];

    Locale selectedLocale = supportedLocales.first;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              LocalizationService.of(context).translate('change_language')),
          content: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButton<Locale>(
                value: selectedLocale,
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    setState(() {
                      selectedLocale = newLocale;
                    });
                  }
                },
                items: supportedLocales
                    .map<DropdownMenuItem<Locale>>((Locale locale) {
                  String languageName;
                  switch (locale.languageCode) {
                    case 'en':
                      languageName = LocalizationService.of(context)
                          .translateSingleWord('english', 'en');
                      break;
                    case 'es':
                      languageName = LocalizationService.of(context)
                          .translateSingleWord('spanish', 'es');
                      break;
                    default:
                      languageName = locale.languageCode;
                  }
                  return DropdownMenuItem<Locale>(
                    value: locale,
                    child: Text(languageName),
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              child: Text(LocalizationService.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(LocalizationService.of(context).translate('save')),
              onPressed: () {
                // Cambia el idioma utilizando el LocaleProvider
                Provider.of<LocaleProvider>(context, listen: false)
                    .setLocale(selectedLocale);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
