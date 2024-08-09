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
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('CarbBoos'),
          ),
          ListTile(
            title: const Text('Menu principal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'CarbBoos')),
              );
            },
          ),
          ListTile(
            title: const Text('Bebida isotónica'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const CreationIsotonicDrink(title: 'Bebida isotónica')),
              );
            },
          ),
          ListTile(
            title: const Text('Creación de geles'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const GelsCreation(title: 'Creación de geles')),
              );
            },
          ),
        ],
      ),
    );
  }
}
