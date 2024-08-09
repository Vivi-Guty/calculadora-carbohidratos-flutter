import 'package:calculadora_de_carbohidratos/login/users.dart';
import 'package:calculadora_de_carbohidratos/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import '../theme/theme_notifier.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 500);

  // Lista simulada de usuarios registrados
  final List<User> users = [
    User(email: 'admin@admin.com', username: 'admin', password: 'admin123'),
    User(email: 'user1@domain.com', username: 'user1', password: 'password1'),
    User(email: 'user2@domain.com', username: 'user2', password: 'password2'),
  ];

  Future<String?> _authLoginUser(LoginData data) {
    final user = User.validateLogin(data.name, data.password, users);
    if (user.email == '' || user.password == '') {
      return Future.delayed(loginTime)
          .then((_) => 'Usuario o contraseña incorrectos');
    }
    return Future.delayed(loginTime).then((_) => null);
  }

  Future<String?> _authSignupUser(SignupData data) {
    final user = User.validateLogin(data.name, data.password, users);
    if (user.email == '' || user.password == '') {
      return Future.delayed(loginTime)
          .then((_) => 'Usuario o contraseña incorrectos');
    }
    return Future.delayed(loginTime).then((_) => null);
  }

  Future<String?> _recoverPassword(String name) {
    final user = User.findByEmail(name, users);
    if (user == null) {
      return Future.delayed(loginTime).then((_) => 'Usuario no encontrado');
    }
    return Future.delayed(loginTime).then((_) => null);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'CarbBoos',
      onLogin: _authLoginUser,
      onSignup: _authSignupUser,
      onRecoverPassword: _recoverPassword,
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
          builder: (context) => const MyHomePage(title: 'CarbBoos'),
        ));
      },
      // Aquí desactivamos la validación del email
      userValidator: (value) {
        // Si quieres desactivar completamente la validación, solo retorna null
        return null; // Permite cualquier valor en el campo de usuario
      },
    );
  }
}
