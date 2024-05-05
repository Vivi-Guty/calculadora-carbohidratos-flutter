import 'package:calculadora_de_carbohidratos/main.dart';
import 'package:flutter/material.dart';
import 'shared_service.dart';

// ignore: camel_case_types
class ratioPersonalizado extends BasePage {
  const ratioPersonalizado({super.key, required super.title});

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
  final mlController = TextEditingController();
  final concentrationController = TextEditingController();
  final maltodextrinController = TextEditingController();
  final fructoseController = TextEditingController();
  int ml = 700;
  int concentration = 8;
  CarbohydrateRatio carbohydrates =
      CarbohydrateRatioImpl(gramsMaltodextrin: 0, gramsFructose: 0);
  Ratio ratio = RatioImpl(maltodextrin: 1, fructose: 0.8);
  SharedService sharedService = SharedService();

  void calculate() {
    setState(() {
      carbohydrates =
          sharedService.calculateCarbohydrates(ml, concentration, ratio);
    });
  }

  @override
  void initState() {
    super.initState();
    mlController.text = ml.toString();
    concentrationController.text = concentration.toString();
    maltodextrinController.text = ratio.maltodextrin.toString();
    fructoseController.text = ratio.fructose.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          child: IconButton(
                            icon: const Icon(Icons.add,
                                color: Colors.green, size: 35),
                            onPressed: () {
                              setState(() {
                                ml = ml + 50;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: mlController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
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
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 60,
                          child: IconButton(
                            icon: const Icon(Icons.remove,
                                color: Colors.red, size: 35),
                            onPressed: () {
                              setState(() {
                                ml = ml - 50;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.transparent,
                height: 25,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          child: IconButton(
                            icon: const Icon(Icons.add,
                                color: Colors.green, size: 35),
                            onPressed: () {
                              setState(() {
                                concentration = concentration + 1;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: concentrationController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              setState(() {
                                concentration = int.parse(value);
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Concentración de bebida (%)',
                              suffix: Text('%'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 60,
                          child: IconButton(
                            icon: const Icon(Icons.remove,
                                color: Colors.red, size: 35),
                            onPressed: () {
                              setState(() {
                                concentration = concentration - 1;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.transparent,
                height: 25,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          child: IconButton(
                            icon: const Icon(Icons.add,
                                color: Colors.green, size: 35),
                            onPressed: () {
                              setState(() {
                                ratio = RatioImpl(
                                    maltodextrin: double.parse(
                                        (ratio.maltodextrin + 1.0)
                                            .toStringAsFixed(2)),
                                    fructose: ratio.fructose);
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: maltodextrinController,
                            onChanged: (value) {
                              if (value.isEmpty ||
                                  double.tryParse(value) == null) {
                                return;
                              }
                              setState(() {
                                ratio = RatioImpl(
                                    maltodextrin: double.parse(
                                        double.parse(value).toStringAsFixed(2)),
                                    fructose: ratio.fructose);
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Maltodextrina (%)',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 60,
                          child: IconButton(
                            icon: const Icon(Icons.remove,
                                color: Colors.red, size: 35),
                            onPressed: () {
                              setState(() {
                                ratio = RatioImpl(
                                    maltodextrin: double.parse(
                                        (ratio.maltodextrin - 1.0)
                                            .toStringAsFixed(2)),
                                    fructose: ratio.fructose);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.transparent,
                height: 25,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          child: IconButton(
                            icon: const Icon(Icons.add,
                                color: Colors.green, size: 35),
                            onPressed: () {
                              setState(() {
                                ratio = RatioImpl(
                                    maltodextrin: ratio.maltodextrin,
                                    fructose: double.parse(
                                        (ratio.fructose + 1.0)
                                            .toStringAsFixed(2)));
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: fructoseController,
                            onChanged: (value) {
                              if (value.isEmpty ||
                                  double.tryParse(value) == null) {
                                return;
                              }
                              setState(() {
                                ratio = RatioImpl(
                                    maltodextrin: ratio.maltodextrin,
                                    fructose: double.parse(double.parse(value)
                                        .toStringAsExponential(2)));
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Fructosa (%)',
                              suffix: Text('%'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 60,
                          child: IconButton(
                            icon: const Icon(Icons.remove,
                                color: Colors.red, size: 35),
                            onPressed: () {
                              setState(() {
                                ratio = RatioImpl(
                                    maltodextrin: ratio.maltodextrin,
                                    fructose: double.parse(
                                        (ratio.fructose - 1.0)
                                            .toStringAsFixed(2)));
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.transparent,
                height: 25,
              ),
              ElevatedButton(
                onPressed: calculate,
                child: const Text('Calcular'),
              ),
              const Divider(
                color: Colors.transparent,
                height: 25,
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
