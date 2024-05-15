import 'package:calculadora_de_carbohidratos/main.dart';
import 'package:flutter/material.dart';
import 'shared_service.dart';

// ignore: camel_case_types
class ratio105 extends BasePage {
  const ratio105({super.key, required super.title});

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
  Ratio ratio = RatioImpl(maltodextrin: 1, fructose: 0.5);
  SharedService sharedService = SharedService();
  ControllerService controllerService = ControllerService();

  void calculate() {
    setState(() {
      carbohydrates =
          sharedService.calculateCarbohydrates(ml, concentration, ratio);
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
              const Divider(
                color: Colors.transparent,
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width:
                      200, // Ajusta este valor para cambiar el tamaño del TextField
                  child: TextField(
                    controller: mlController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        return;
                      }
                      int? intValue = int.tryParse(value);
                      if (intValue != null) {
                        setState(() {
                          ml = intValue;
                        });
                      } else {
                        mlController.text = concentration.toString();
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Tamaño de bebida',
                      suffix: Text(' ml'),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.transparent,
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: IconButton(
                        icon: const Icon(Icons.add,
                            color: Colors.green, size: 50.0),
                        onPressed: () {
                          setState(() {
                            controllerService.increment(mlController, 50);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            controllerService.clear(mlController);
                          });
                        },
                        child: const Text('Limpiar'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: IconButton(
                        icon: const Icon(Icons.remove,
                            color: Colors.red, size: 50.0),
                        onPressed: () {
                          setState(() {
                            controllerService.decrement(mlController, 50);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
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
              Text(
                  'Gramos de maltodextrina: ${carbohydrates.gramsMaltodextrin.toStringAsFixed(0)}g'),
              Text(
                  'Gramos de fructosa: ${carbohydrates.gramsFructose.toStringAsFixed(0)}g'),
            ],
          ),
        ),
      ),
    );
  }
}
