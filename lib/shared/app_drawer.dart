import 'package:calculadora_de_carbohidratos/services/localization_service.dart';
import 'package:flutter/material.dart';
import '../../creation_isotonic_drink.dart';
import '../../gels_creation.dart';
import '../../my_home_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
                LocalizationService.of(context).translate('application_name')),
          ),
          ListTile(
            title: Text(LocalizationService.of(context).translate('main_menu')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                        title: LocalizationService.of(context)
                            .translate('application_name'))),
              );
            },
          ),
          ListTile(
            title: Text(
                LocalizationService.of(context).translate('isotonic_drink')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreationIsotonicDrink(
                        title: LocalizationService.of(context)
                            .translate('isotonic_drink'))),
              );
            },
          ),
          ListTile(
            title:
                Text(LocalizationService.of(context).translate('gel_creation')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GelsCreation(
                        title: LocalizationService.of(context)
                            .translate('gel_creation'))),
              );
            },
          ),
        ],
      ),
    );
  }
}
