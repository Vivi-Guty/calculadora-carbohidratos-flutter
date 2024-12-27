import 'dart:convert';
import 'package:calculadora_de_carbohidratos/login/users.dart';
import 'package:calculadora_de_carbohidratos/my_home_page.dart';
import 'package:calculadora_de_carbohidratos/provider/user_provider.dart';
import 'package:calculadora_de_carbohidratos/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import '../theme/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  late final List<User> users = [];

  // Método para cargar usuarios desde el archivo local db.json
  Future<void> loadLocalUsers() async {
    final String jsonString = await rootBundle.loadString('lib/db.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    final List<dynamic> userList = data['users'];
    users.clear();
    users.addAll(userList.map((user) => User.fromMap(user)).toList());
  }

  Future<String?> _authLoginUser(BuildContext context, LoginData data) async {
    if (users.isEmpty) {
      await loadLocalUsers(); // Cargar usuarios si no están cargados
    }

    final user = User.validateLogin(data.name, data.password, users);
    if (user.email.isEmpty || user.password.isEmpty) {
      return LocalizationService.of(context)
          .translate('incorrect_user_or_password');
    }

    // Cachear el usuario en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toMap()));

    if (!context.mounted) return null;

    // Guardar el usuario en el UserProvider
    Provider.of<UserProvider>(context, listen: false).setUser(user);

    return null;
  }

  Future<String?> _authSignupUser(BuildContext context, SignupData data) async {
    if (users.isEmpty) {
      await loadLocalUsers(); // Cargar usuarios si no están cargados
    }

    final user = User.validateLogin(data.name, data.password, users);
    if (user.email.isEmpty || user.password.isEmpty) {
      return Future.delayed(Duration.zero).then((_) =>
          LocalizationService.of(context)
              .translate('incorrect_user_or_password'));
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toMap()));

    if (!context.mounted) return null;

    Provider.of<UserProvider>(context, listen: false).setUser(user);

    return Future.delayed(Duration.zero).then((_) => null);
  }

  Future<String?> _recoverPassword(BuildContext context, String name) async {
    if (users.isEmpty) {
      await loadLocalUsers(); // Cargar usuarios si no están cargados
    }

    final user = User.findByEmail(name, users);
    if (user == null || user.email.isEmpty) {
      return Future.delayed(Duration.zero).then(
          (_) => LocalizationService.of(context).translate('user_not_found'));
    }
    return Future.delayed(Duration.zero).then((_) => null);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadLocalUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildLoginWidget(context);
      },
    );
  }

  Widget _buildLoginWidget(BuildContext context) {
    return FlutterLogin(
      title: LocalizationService.of(context).translate('application_name'),
      onLogin: (LoginData data) => _authLoginUser(context, data),
      onSignup: (SignupData data) => _authSignupUser(context, data),
      onRecoverPassword: (String name) => _recoverPassword(context, name),
      theme: LoginTheme(
        primaryColor:
            Provider.of<ThemeNotifier>(context).currentTheme.primaryColor,
        accentColor: Provider.of<ThemeNotifier>(context)
            .currentTheme
            .secondaryHeaderColor,
        buttonTheme: LoginButtonTheme(
          backgroundColor:
              Provider.of<ThemeNotifier>(context).currentTheme.primaryColor,
        ),
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(
              title: LocalizationService.of(context)
                  .translate('application_name')),
        ));
      },
      userValidator: (value) => null,
    );
  }
}
