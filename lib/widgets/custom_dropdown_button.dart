import 'dart:convert';

import 'package:calculadora_de_carbohidratos/login/users.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ratio_dropdown_button.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<RatioDropdownButton> list;
  final RatioDropdownButton? selectedValue;
  final ValueChanged<RatioDropdownButton?> onSelected;

  const CustomDropdownButton({
    super.key,
    required this.list,
    required this.selectedValue,
    required this.onSelected,
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
          return DropdownMenu<RatioDropdownButton>(
            initialSelection: selectedValue,
            dropdownMenuEntries: list
                .map<DropdownMenuEntry<RatioDropdownButton>>(
                    (RatioDropdownButton value) {
              return DropdownMenuEntry<RatioDropdownButton>(
                  value: value, label: value.nameDropdown);
            }).toList(),
            onSelected: onSelected,
            enabled: user.isPremium,
          );
        }
      },
    );
  }
}
