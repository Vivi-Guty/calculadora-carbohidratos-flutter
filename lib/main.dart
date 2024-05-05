import 'package:calculadora_de_carbohidratos/personalized_ratio.dart';
import 'package:calculadora_de_carbohidratos/ratio105.dart';
import 'package:calculadora_de_carbohidratos/ratio108.dart';
import 'package:calculadora_de_carbohidratos/ratio11.dart';
import 'package:flutter/material.dart';

abstract class BasePage extends StatelessWidget {
  final String title;

  const BasePage({super.key, required this.title});

  Widget pageBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Calculadora de carbohidratos'),
            ),
            ListTile(
              title: const Text('Menu principal'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: 'Calculadora de carbohidratos',
                          )),
                );
              },
            ),
            ListTile(
              title: const Text('Ratio 1:0.8'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ratio108(title: 'Ratio 1:0.8')),
                );
              },
            ),
            ListTile(
              title: const Text('Ratio 1:0.5'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ratio105(title: 'Ratio 1:0.5')),
                );
              },
            ),
            ListTile(
              title: const Text('Ratio 1:1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ratio11(title: 'Ratio 1:1')),
                );
              },
            ),
            ListTile(
              title: const Text('Ratio personalizado'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ratioPersonalizado(
                          title: 'Ratio personalizado')),
                );
              },
            ),
          ],
        ),
      ),
      body: pageBody(),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyHomePage(title: 'Calculadora de carbohidratos'),
  ));
}

class MyHomePage extends BasePage {
  const MyHomePage({super.key, required super.title});

  @override
  Widget pageBody() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Text(
            'En esta aplicación se calcularán la cantidad de Fructosa y '
            'MaltoDextrina que se deben consumir en función de los mililitros '
            'de agua.'),
      ),
    );
  }
}
