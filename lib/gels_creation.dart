import 'package:calculadora_de_carbohidratos/main.dart';
import 'package:flutter/material.dart';
import 'shared_service.dart';

// ignore: camel_case_types
class gelsCreation extends BasePage {
  const gelsCreation({super.key, required super.title});

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
  final numberGelsController = TextEditingController();
  final maltodextrinController = TextEditingController();
  final fructoseController = TextEditingController();
  int ml = 700;
  int concentration = 8;
  int numberGels = 1;
  CarbohydrateRatio carbohydrates =
      CarbohydrateRatioImpl(gramsMaltodextrin: 0, gramsFructose: 0);
  Ratio ratio = RatioImpl(maltodextrin: 1, fructose: 0.8);
  SharedService sharedService = SharedService();
  ControllerService controllerService = ControllerService();
  List<String> list = <String>[
    'Ratio 1:0,8',
    'Ratio 1:0,5',
    'Ratio personalizado'
  ];
  String dropdownValue = '';

  void calculate() {
    setState(() {
      carbohydrates = sharedService.calculateCarbohydrates(
          int.parse(mlController.text),
          int.parse(concentrationController.text),
          ratio);
    });
  }

  void gelCalculate() {
    setState(() {
      carbohydrates = sharedService.gelCalculator(
          int.parse(mlController.text),
          int.parse(concentrationController.text),
          ratio,
          int.parse(numberGelsController.text));
    });
  }

  void updateDropdownValue(String? newValue) {
    setState(() {
      dropdownValue = newValue!;
    });
  }

  @override
  void initState() {
    super.initState();
    mlController.text = ml.toString();
    numberGelsController.text = numberGels.toString();
    concentrationController.text = concentration.toString();
    maltodextrinController.text = ratio.maltodextrin.toString();
    fructoseController.text = ratio.fructose.toString();
    dropdownValue = list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // CustomRow(
              //     controller: mlController,
              //     title: 'Volumen de bebida',
              //     magnitude: 'ml'),
              // const Divider(
              //   color: Colors.transparent,
              //   height: 25,
              // ),
              CustomDropdownButton(
                list: list,
                selectedValue: dropdownValue,
                onSelected: updateDropdownValue,
              ),
              const Divider(
                color: Colors.transparent,
                height: 25,
              ),
              CustomRow(
                controller: numberGelsController,
                title: 'Numero de Geles a preparar',
                deltaValue: 1,
              ),
              const Divider(
                color: Colors.transparent,
                height: 25,
              ),
              if (dropdownValue == 'Ratio personalizado') ...[
                // CustomRow(
                //   controller: concentrationController,
                //   title: 'Concentración de bebida',
                //   magnitude: '%',
                //   deltaValue: 1,
                // ),
                // const Divider(
                //   color: Colors.transparent,
                //   height: 25,
                // ),
                CustomRowWithRatio(
                  controller: maltodextrinController,
                  ratio: ratio,
                  title: 'Maltodextrina (%)',
                  concentration: concentration,
                  willBeChangedMaltodextrin: true,
                  deltaValue: 0.1,
                ),
                const Divider(
                  color: Colors.transparent,
                  height: 25,
                ),
                CustomRowWithRatio(
                  controller: fructoseController,
                  ratio: ratio,
                  title: 'Fructosa (%)',
                  concentration: concentration,
                  willBeChangedMaltodextrin: false,
                  deltaValue: 0.1,
                ),
                const Divider(
                  color: Colors.transparent,
                  height: 25,
                ),
              ],
              ElevatedButton(
                onPressed: gelCalculate,
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
              Text('Tamaño del agua: ${dropdownValue}'),
            ],
          ),
        ),
      ),
    );
  }
}
