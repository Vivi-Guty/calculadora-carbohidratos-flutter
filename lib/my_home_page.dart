import 'dart:convert';

import 'package:calculadora_de_carbohidratos/login/users.dart';
import 'package:calculadora_de_carbohidratos/services/localization_service.dart';
import 'package:calculadora_de_carbohidratos/shared/base_page.dart';
import 'package:calculadora_de_carbohidratos/widgets/custom_card_main.dart';
import 'package:calculadora_de_carbohidratos/widgets/personalized_card_multiple.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends BasePage {
  const MyHomePage({super.key, required super.title});

  Future<User> _getCachedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      return User.fromMap(jsonDecode(userJson));
    }
    return User(email: '', username: '', password: '', isPremium: false);
  }

  @override
  Widget pageBody() {
    return FutureBuilder<User?>(
      future: _getCachedUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('Usuario no encontrado'));
        }

        User? user = snapshot.data;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              CustomCardMain(
                title: Text((LocalizationService.of(context)?.translate('description') ?? 'Tradución no disponible') + user!.username,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(LocalizationService.of(context)?.translate('app_description') ?? 'Tradución no disponible'),
              ),
              CustomCardMain(
                title: Text(LocalizationService.of(context)?.translate('usage_drink') ?? 'Tradución no disponible',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                padding: 0,
                top: 30,
                bottom: 8,
                subtitle: Text(LocalizationService.of(context)?.translate('usage_drink_description') ?? 'Tradución no disponible'),
              ),
              PersonalizedCardMultiple(listTiles: [
                ListTile(
                  leading: const Icon(Icons.local_fire_department),
                  iconColor: Colors.red,
                  title: Text(
                    LocalizationService.of(context)?.translate('maltodextrin_grams') ?? 'Tradución no disponible',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    LocalizationService.of(context)?.translate('maltodextrin_description') ?? 'Tradución no disponible'
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.spa),
                  iconColor: Colors.red,
                  title: Text(
                    LocalizationService.of(context)?.translate('fructose_grams') ?? 'Tradución no disponible',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    LocalizationService.of(context)?.translate('fructose_description') ?? 'Tradución no disponible',
                  ),
                ),
              ]),
              CustomCardMain(
                title: Text(LocalizationService.of(context)?.translate('usage_gels') ?? 'Tradución no disponible',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                padding: 0,
                top: 46,
                bottom: 8,
                subtitle: Text(
                  LocalizationService.of(context)?.translate('usage_gels_description') ?? 'Tradución no disponible',
                ),
              ),
              PersonalizedCardMultiple(listTiles: [
                ListTile(
                  leading: const Icon(Icons.energy_savings_leaf),
                  iconColor: Colors.red,
                  title: Text(
                    LocalizationService.of(context)?.translate('maltodextrin_grams') ?? 'Tradución no disponible',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    LocalizationService.of(context)?.translate('maltodextrin_description') ?? 'Tradución no disponible',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.energy_savings_leaf),
                  iconColor: Colors.red,
                  title: Text(
                    LocalizationService.of(context)?.translate('fructose_grams') ?? 'Tradución no disponible',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    LocalizationService.of(context)?.translate('fructose_description') ?? 'Tradución no disponible',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.emoji_food_beverage),
                  iconColor: const Color.fromARGB(255, 11, 187, 14),
                  title: Text(
                    LocalizationService.of(context)?.translate('flavoring_grams') ?? 'Tradución no disponible',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    LocalizationService.of(context)?.translate('flavoring_description') ?? 'Tradución no disponible',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.emoji_food_beverage),
                  iconColor: const Color.fromARGB(255, 11, 187, 14),
                  title: Text(
                    LocalizationService.of(context)?.translate('salts_grams') ?? 'Tradución no disponible',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    LocalizationService.of(context)?.translate('salts_description') ?? 'Tradución no disponible',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.local_drink),
                  iconColor: Colors.blue,
                  title: Text(
                    LocalizationService.of(context)?.translate('water_ml') ?? 'Tradución no disponible',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    LocalizationService.of(context)?.translate('water_description') ?? 'Tradución no disponible',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.monitor_weight),
                  iconColor: const Color.fromARGB(255, 223, 182, 18),
                  title: Text(
                    LocalizationService.of(context)?.translate('gel_weight') ?? 'Tradución no disponible',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    LocalizationService.of(context)?.translate('gel_weight_description') ?? 'Tradución no disponible',
                  ),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }
}
