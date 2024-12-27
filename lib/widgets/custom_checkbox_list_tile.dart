import 'dart:convert';

import 'package:calculadora_de_carbohidratos/login/users.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final bool? isChecked;
  final String title;
  final Color checkColor;
  final Color fillColorIsChecked;
  final Color fillColorIsNotChecked;
  final ValueChanged<bool?>? onChanged;

  const CustomCheckboxListTile({
    super.key,
    required this.isChecked,
    required this.title,
    required this.onChanged,
    this.checkColor = Colors.black,
    this.fillColorIsChecked = Colors.green,
    this.fillColorIsNotChecked = Colors.transparent,
  });

  Future<User> _getCachedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      return User.fromMap(jsonDecode(userJson));
    }
    return User(email: '', username: '', password: '', isPremium: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _getCachedUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          User user = snapshot.data!;
          return CheckboxListTile(
            title: Text(title),
            controlAffinity: ListTileControlAffinity.leading,
            value: isChecked,
            checkColor: checkColor,
            fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (isChecked == true) {
                return fillColorIsChecked;
              }
              return fillColorIsNotChecked;
            }),
            onChanged: onChanged,
            enabled: user.isPremium,
          );
        }
      },
    );
  }
}
