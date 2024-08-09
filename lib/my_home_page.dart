import 'package:calculadora_de_carbohidratos/shared/base_page.dart';
import 'package:calculadora_de_carbohidratos/widgets/custom_card_main.dart';
import 'package:calculadora_de_carbohidratos/widgets/personalized_card_multiple.dart';
import 'package:flutter/material.dart';

class MyHomePage extends BasePage {
  const MyHomePage({super.key, required super.title});

  @override
  Widget pageBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          CustomCardMain(
            title: const Text(
              'Explicación de la aplicación',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'En esta aplicación se calcularán las cantidades de fructosa, '
              'maltoDextrina y sales que se deben hechar en función de la '
              'cantidad de geles que queramos crear o la cantidad de agua '
              'que queramos hechar, vamos a poder modificar el ratio de '
              'carbohidratos, tambien vamos a poder crear geles o bebida '
              'isotónicas personalizadas.',
            ),
          ),
          CustomCardMain(
            title: const Text(
              'Modo de uso de la Bebida isotónica',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
              'al botón de calcular y nos saldrán los resultados.',
            ),
          ),
          const PersonalizedCardMultiple(listTiles: [
            ListTile(
              leading: Icon(Icons.local_fire_department),
              iconColor: Colors.red,
              title: Text(
                'Gramos de maltodextrina',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Esto será la cantidad de maltodextrina que tendremos que hechar en la mezcla',
              ),
            ),
            ListTile(
              leading: Icon(Icons.spa),
              iconColor: Colors.red,
              title: Text(
                'Gramos de fructosa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Esto será la cantidad de fructosa que tendremos que hechar en la mezcla',
              ),
            ),
          ]),
          CustomCardMain(
            title: const Text(
              'Modo de uso de Creaciones de Geles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            padding: 0,
            top: 46,
            bottom: 8,
            subtitle: const Text(
              'Tenemso la opción de elegir el ratio de carbohidratos que, '
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
              'los datos le damos  a calcular y nos saldrán los resultados.',
            ),
          ),
          const PersonalizedCardMultiple(listTiles: [
            ListTile(
              leading: Icon(Icons.energy_savings_leaf),
              iconColor: Colors.red,
              title: Text(
                'Gramos de maltodextrina',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Esto será la cantidad de maltodextrina que tendremos que hechar en la mezcla',
              ),
            ),
            ListTile(
              leading: Icon(Icons.energy_savings_leaf),
              iconColor: Colors.red,
              title: Text(
                'Gramos de fructosa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Esto será la cantidad de fructosa que tendremos que hechar en la mezcla',
              ),
            ),
            ListTile(
              leading: Icon(Icons.emoji_food_beverage),
              iconColor: Color.fromARGB(255, 11, 187, 14),
              title: Text(
                'Gramos de saborizante',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Esto será la cantidad de saborizante que tendremos que hechar en la mezcla',
              ),
            ),
            ListTile(
              leading: Icon(Icons.emoji_food_beverage),
              iconColor: Color.fromARGB(255, 11, 187, 14),
              title: Text(
                'Gramos de sales',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Esto será la cantidad de sales que tendremos que hechar en la mezcla',
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_drink),
              iconColor: Colors.blue,
              title: Text(
                'Mililitros de agua',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Esto será la cantidad de agua que tendremos que hechar en la mezcla',
              ),
            ),
            ListTile(
              leading: Icon(Icons.monitor_weight),
              iconColor: Color.fromARGB(255, 223, 182, 18),
              title: Text(
                'Peso por gel',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Esto es el peso que tendrá cada gel que creemos',
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
