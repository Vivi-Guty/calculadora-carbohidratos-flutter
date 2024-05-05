import 'package:calculadora_de_carbohidratos/main.dart';
import 'package:flutter/material.dart';
import 'shared_service.dart';

// ignore: camel_case_types
class ratio11 extends BasePage {
  const ratio11({super.key, required super.title});

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
  Ratio ratio = RatioImpl(maltodextrin: 1, fructose: 1);
  SharedService sharedService = SharedService();

  void calculate() {
    setState(() {
      carbohydrates =
          sharedService.calculateCarbohydrates(ml, concentration, ratio);
    });
  }

  void _increment() {
    setState(() {
      ml = ml + 50;
    });
  }

  void _decrement() {
    setState(() {
      ml = ml - 50;
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
                  width: 200,
                  child: TextField(
                    controller: mlController,
                    onChanged: (value) {
                      setState(() {
                        ml = int.parse(value);
                      });
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
                            _increment();
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
                            ml = 0;
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
                            _decrement();
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
