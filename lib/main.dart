import 'package:calculadora_de_carbohidratos/creation_isotonic_drink.dart';
import 'package:calculadora_de_carbohidratos/gels_creation.dart';
// import 'package:calculadora_de_carbohidratos/personalized_ratio.dart';
// import 'package:calculadora_de_carbohidratos/ratio105.dart';
// import 'package:calculadora_de_carbohidratos/ratio108.dart';
// import 'package:calculadora_de_carbohidratos/ratio11.dart';
import 'package:calculadora_de_carbohidratos/shared_service.dart';
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
              child: Text('CarbBoos'),
            ),
            ListTile(
              title: const Text('Menu principal'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: 'CarbBoos',
                          )),
                );
              },
            ),
            // ListTile(
            //   title: const Text('Ratio 1:0.8'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               const ratio108(title: 'Ratio 1:0.8')),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: const Text('Ratio 1:0.5'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               const ratio105(title: 'Ratio 1:0.5')),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: const Text('Ratio 1:1'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ratio11(title: 'Ratio 1:1')),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: const Text('Ratio personalizado'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ratioPersonalizado(
            //               title: 'Ratio personalizado')),
            //     );
            //   },
            // ),
            ListTile(
              title: const Text('Bebida isotónica'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const creationIsotonicDrink(
                          title: 'Bebida isotónica')),
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
                          const gelsCreation(title: 'Creación de geles')),
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
    home: MyHomePage(title: 'CarbBoos'),
  ));
}

class MyHomePage extends BasePage {
  const MyHomePage({super.key, required super.title});

  @override
  Widget pageBody() {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: Text('Calculadora de Carbohidratos')),
        body: SingleChildScrollView(
          // padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                    'En esta aplicación se calcularán las cantidades de fructosa, '
                    'maltoDextrina y sales que se deben hechar en función de la '
                    'cantidad de geles que queramos crear o la cantaidad de agua '
                    'que queramos hechar, vamos a poder modificar el ratio de '
                    'carbohidratos, tambien vamos a poder crear geles o bebida '
                    'isotónicas personalizadas.'),
              ),
              const Divider(color: Colors.grey),
              const Text(
                'Modo de uso de la Bebida isotónica',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                    'Tenemos la opción de elegir el ratio de carbohidratos que, '
                    'el ratio es la cantidad de maltodextrina y fructosa que '
                    'quermos en la mezcla, por defecto el ratio es 1:0.8, si '
                    'queremos cambiarlo en la parte superior de la pantalla '
                    'tenemos un botón que nos permite cambiar el ratio, una vez '
                    'que hemos elegido el ratio que queremos, en la parte inferior '
                    'de la pantalla tendremos que introducir la cantidad de agua '
                    'en caso de que ayamos elegido la opción de ratio personalizado '
                    'tendremos que introducir el ratio de maltodextrina y fructosa '
                    'y la cantiadad de concentración de carbohidratos que queremos '
                    'en la mezcla, una vez que hemos introducido los datos le damos '
                    'al botón de calcular y nos saldrán los resultados.'),
              ),
              CustomRowOfText(
                text: const Text(
                  'Gramos de maltodextrina',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                icon: Icons.local_fire_department,
                color: Colors.red,
              ),
              CustomPaddingWithText(
                  text: const Text(
                      'Esto sera la cantidad de maltodextrina que tendremos que hechar en la mezcla')),
              CustomRowOfText(
                text: const Text(
                  'Gramos de fructosa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                icon: Icons.spa,
                color: Colors.red,
              ),
              CustomPaddingWithText(
                  text: const Text(
                      'Esto sera la cantidad de fructosa que tendremos que hechar en la mezcla')),
              const Text(
                'Modo de uso de Creaciones de Geles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(''),
              ),
              CustomRowOfText(
                text: const Text(
                  'Gramos de maltodextrina',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                icon: Icons.local_fire_department,
                color: Colors.red,
              ),
              CustomPaddingWithText(
                  text: const Text(
                      'Esto sera la cantidad de maltodextrina que tendremos que hechar en la mezcla')),
              CustomRowOfText(
                text: const Text(
                  'Gramos de fructosa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                icon: Icons.spa,
                color: Colors.red,
              ),
              CustomPaddingWithText(
                  text: const Text(
                      'Esto sera la cantidad de fructosa que tendremos que hechar en la mezcla')),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.emoji_food_beverage,
                    color: Colors.black, size: 24.0),
                SizedBox(width: 8),
                Text(
                  'Gramos de saborizante',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ]),
              CustomPaddingWithText(
                  text: const Text(
                      'Esto sera la cantidad de fructosa que tendremos que hechar en la mezcla')),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.local_drink, color: Colors.black, size: 24.0),
                SizedBox(width: 8),
                Text(
                  'Gramos de sales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ]),
              CustomPaddingWithText(
                  text: const Text(
                      'Esto sera la cantidad de fructosa que tendremos que hechar en la mezcla')),
              CustomRowOfText(
                text: const Text(
                  'Mililitros de agua',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                icon: Icons.water,
                color: Colors.blue,
              ),
              CustomPaddingWithText(
                  text: const Text(
                      'Esto sera la cantidad de fructosa que tendremos que hechar en la mezcla')),
              CustomRowOfText(
                text: const Text(
                  'Peso por gel',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                icon: Icons.monitor_weight,
                color: Colors.black,
              ),
              CustomPaddingWithText(
                  text: const Text(
                      'Esto sera la cantidad de fructosa que tendremos que hechar en la mezcla')),
            ],
          ),
        ),
      ),
    );
  }
}
