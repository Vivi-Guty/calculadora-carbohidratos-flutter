import 'package:calculadora_de_carbohidratos/main.dart';
import 'package:flutter/material.dart';
import 'shared_service.dart';

// ignore: camel_case_types
class ratio108 extends BasePage {
  const ratio108({super.key, required super.title});

  @override
  Widget pageBody() {
    return const RatioInput();
  }
}

class RatioInput extends StatefulWidget {
  const RatioInput({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RatioInputState createState() => _RatioInputState();
}

class _RatioInputState extends State<RatioInput> {
  int ml = 700;
  int concentration = 8;
  CarbohydrateRatio carbohydrates =
      CarbohydrateRatioImpl(gramsMaltodextrin: 0, gramsFructose: 0);
  Ratio ratio = RatioImpl(maltodextrin: 1, fructose: 0.8);
  SharedService sharedService = SharedService();
  ControllerService controllerService = ControllerService();

  void calculate() {
    setState(() {
      carbohydrates = sharedService.calculateCarbohydrates(
          int.parse(mlController.text), concentration, ratio);
    });
  }

  final mlController = TextEditingController();
  @override
  void initState() {
    super.initState();
    mlController.text = ml.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomRow(
                  controller: mlController,
                  title: 'Volumen de bebida',
                  magnitude: 'ml'),
              const Divider(
                color: Colors.transparent,
                height: 20,
              ),
              CustomRowClear(controller: mlController),
              const Divider(
                color: Colors.transparent,
                height: 20,
              ),
              ElevatedButton(
                onPressed: calculate,
                child: const Text('Calcular'),
              ),
              const Divider(
                color: Colors.transparent,
                height: 20,
              ),
              ResultRow(
                label: 'Gramos de maltodextrina',
                value: '${carbohydrates.gramsMaltodextrin.toString()} gramos',
                icon: Icons.local_fire_department,
                color: Colors.red,
                iconSize: 24.0,
              ),
              ResultRow(
                label: 'Gramos de fructosa',
                value: '${carbohydrates.gramsFructose.toString()} gramos',
                icon: Icons.spa,
                color: Colors.red,
                iconSize: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
