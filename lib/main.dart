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
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              CustomCardMain(
                title: const Text('Explicación de la aplicación', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: const Text(
                      'En esta aplicación se calcularán las cantidades de fructosa, '
                      'maltoDextrina y sales que se deben hechar en función de la '
                      'cantidad de geles que queramos crear o la cantaidad de agua '
                      'que queramos hechar, vamos a poder modificar el ratio de '
                      'carbohidratos, tambien vamos a poder crear geles o bebida '
                      'isotónicas personalizadas.')),
              CustomCardMain(
                  title: const Text('Modo de uso de la Bebida isotónica', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  padding: 0,
                  top: 30,
                  bottom: 8,
                  subtitle: const Text(
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
                        'al botón de calcular y nos saldrán los resultados.')),
              CustomCardMain(
                icon: Icons.local_fire_department,
                iconColor: Colors.red,
                padding: 8,
                title: const Text(
                  'Gramos de maltodextrina',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: const Text(
                      'Esto sera la cantidad de maltodextrina que tendremos que hechar en la mezcla')),
              CustomCardMain(
                icon: Icons.spa,
                iconColor: Colors.red,
                padding: 8,
                title: const Text(
                  'Gramos de fructosa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: const Text(
                      'Esto sera la cantidad de fructosa que tendremos que hechar en la mezcla')),
              CustomCardMain(
                title: const Text(
                'Modo de uso de Creaciones de Geles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                padding: 0,
                top: 46,
                bottom: 8,
                subtitle: const Text('Tenemso la opción de elegir el ratio de carbohidratos que, '
                    'el ratio es la cantidad de maltodextrina y fructosa que '
                    'quermos en la mezcla, por defecto el ratio es 1:0.8, si '
                    'queremos cambiarlo en la parte superior de la pantalla '
                    'tenemos un botón que nos permite cambiar el ratio, una vez '
                    'que hemos elegido el ratio que queremos, en la parte inferior '
                    'de la pantalla tendremos la opción de elegir si queremos saborizante '
                    'o si queremos sales, en caso de que ayamos elegido la opción de '
                    'ratio personalizado tenemos la opción de introducir el ratio de '
                    'maltodextrina, fructosa, saborizante, sales y agua (para '
                    'ajustar la cantidad de agua en la mezcla, introduce la cantidad '
                    'deseada (por defecto, un tercio del peso total). Por ejemplo, '
                    'para una mezcla de 100g, el valor predeterminado es 33g de agua. '
                    'Si deseas más agua, introduce un número menor; si deseas menos '
                    'agua, introduce un número mayor. una vez que hemos introducido '
                    'los datos le damos  a calcular y nos saldrán los resultados.')),
              CustomCardMain(
                icon: Icons.local_fire_department,
                iconColor: Colors.red,
                padding: 8,
                title: const Text(
                  'Gramos de maltodextrina',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: const Text(
                      'Esto sera la cantidad de maltodextrina que tendremos que hechar en la mezcla')),
              CustomCardMain(
                icon: Icons.spa,
                iconColor: Colors.red,
                padding: 8,
                title: const Text(
                  'Gramos de fructosa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: const Text(
                      'Esto sera la cantidad de fructosa que tendremos que hechar en la mezcla')),
              CustomCardMain(
                icon: Icons.local_fire_department,
                iconColor: Colors.red,
                padding: 8,
                title: const Text(
                  'Gramos de saborizante',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: const Text(
                      'Esto sera la cantidad de saborizante que tendremos que hechar en la mezcla')),
              CustomCardMain(
                icon: Icons.spa,
                iconColor: Colors.red,
                padding: 8,
                title: const Text(
                  'Gramos de sales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: const Text(
                      'Esto sera la cantidad de sales que tendremos que hechar en la mezcla')),
              CustomCardMain(
                icon: Icons.water,
                iconColor: Colors.blue,
                padding: 8,
                title: const Text(
                  'Mililitros de agua',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                  subtitle: const Text(
                      'Esto sera la cantidad de agua que tendremos que hechar en la mezcla')),
              CustomCardMain(
                icon: Icons.monitor_weight,
                iconColor: Colors.black,
                padding: 8,
                title: const Text(
                  'Peso por gel',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: const Text(
                      'Esto es el peso que tendrá cada gel que creemos')),
            ],
          ),
        ),
      ),
    );
  }
}
