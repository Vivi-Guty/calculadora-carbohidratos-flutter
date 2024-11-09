import 'dart:convert';
import 'package:calculadora_de_carbohidratos/login/users.dart';
import 'package:calculadora_de_carbohidratos/my_home_page.dart';
import 'package:calculadora_de_carbohidratos/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http; // Add this line to import the http package
import '../theme/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<User?> fetchUserFromLocalServer(String email, String password) async {
//   final response = await http.get(Uri.parse('http://localhost:3000/users'));

//   if (response.statusCode == 200) {
//     List<dynamic> users = jsonDecode(response.body);
//     for (var userData in users) {
//       if (userData['email'] == email && userData['password'] == password) {
//         return User(
//           email: userData['email'],
//           username: userData['username'],
//           password: userData['password'],
//           isPremium: userData['isPremium'],
//         );
//       }
//     }
//   } else {
//     throw Exception('Failed to load users');
//   }
//   return null;
// }

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  Future<List> fetchUserFromLocalServer() async {
    final jsondata = await rootBundle.loadString('assets/db.json');
    final Map<String, dynamic> data = json.decode(jsondata);
    return data['users'] != null ? (data['users'] as List).map((e) => User.fromMap(e)).toList() : [];
  }
  // Lista simulada de usuarios registrados
  final List<User> users = //await fetchUserFromLocalServer();
  [
    User(
        email: 'admin@admin.com',
        username: 'admin',
        password: 'admin123',
        isPremium: true),
    User(
        email: 'victor@gmail.com',
        username: 'victor',
        password: 'victor',
        isPremium: false),
    User(
        email: 'user1@domain.com',
        username: 'user1',
        password: 'password1',
        isPremium: false),
    User(
        email: 'user2@domain.com',
        username: 'user2',
        password: 'password2',
        isPremium: false),
  ];

  Future<String?>? _authLoginUser(BuildContext context, LoginData data) async {
    final user = User.validateLogin(data.name, data.password, users);
    if (user.email == '' || user.password == '') {
      return 'Usuario o contraseña incorrectos';
    }

    // Cachear el usuario en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toMap()));

    // Verificar si el widget aún está montado antes de usar el BuildContext
    if (!context.mounted) return null;

    // Guardar el usuario en el UserProvider
    Provider.of<UserProvider>(context, listen: false).setUser(user);

    return null;
  }

  Future<String?> _authSignupUser(BuildContext context, SignupData data) async {
    final user = User.validateLogin(data.name, data.password, users);
    if (user.email == '' || user.password == '') {
      return Future.delayed(Duration.zero)
          .then((_) => 'Usuario o contraseña incorrectos');
    }

    // Cachear el usuario en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toMap()));

    // Verificar si el widget aún está montado antes de usar el BuildContext
    if (!context.mounted) return null;

    // Guardar el usuario en el UserProvider
    Provider.of<UserProvider>(context, listen: false).setUser(user);

    return Future.delayed(Duration.zero).then((_) => null);
  }

  Future<String?> _recoverPassword(String name) {
    final user = User.findByEmail(name, users);
    if (user == null) {
      return Future.delayed(Duration.zero).then((_) => 'Usuario no encontrado');
    }
    return Future.delayed(Duration.zero).then((_) => null);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'CarbBoos',
      onLogin: (LoginData data) => _authLoginUser(context, data),
      onSignup: (SignupData data) => _authSignupUser(context, data),
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
