import 'package:calculadora_de_carbohidratos/models/gel_mix.dart';
import 'package:calculadora_de_carbohidratos/models/ratio.dart';
import 'package:calculadora_de_carbohidratos/models/ratio_dropdown_button.dart';
import 'package:calculadora_de_carbohidratos/shared/base_page.dart';
import 'package:flutter/material.dart';
import 'services/shared_service.dart';
import 'widgets/custom_dropdown_button.dart';
import 'widgets/custom_row.dart';
import 'widgets/custom_row_with_ratio.dart';
import 'widgets/custom_checkbox_list_tile.dart';
import 'widgets/result_row.dart';

class GelsCreation extends BasePage {
  const GelsCreation({super.key, required super.title});

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
  final amountCarbohydratesPerGelsController = TextEditingController();
  final numberGelsController = TextEditingController();
  final maltodextrinController = TextEditingController();
  final fructoseController = TextEditingController();
  final flavoringController = TextEditingController();
  final saltsController = TextEditingController();
  final wantMoreWaterController = TextEditingController();
  int numberGels = 1;
  int amountCarbohydratesPerGels = 30;
  GelMix gelMix = GelMixImpl(
      gramsMaltodextrin: 0.0,
      gramsFructose: 0.0,
      flavorings: 0.0,
      salts: 0.0,
      water: 0,
      gelWeight: 0);
  Ratio ratio = RatioImpl(maltodextrin: 1, fructose: 0.8);
  SharedService sharedService = SharedService();
  List<RatioDropdownButton> ratioDropdownButtonList = <RatioDropdownButton>[];
  RatioDropdownButton dropdownValue = RatioDropdownButtonImpl(
      ratio: RatioImpl(maltodextrin: 1, fructose: 0.8),
      nameDropdown: 'Ratio 1:0,8');
  bool? isCheckedFlavoring = true;
  bool? isCheckedSalts = true;
  bool? wantMoreWater = false;

  void gelCalculate() {
    setState(() {
      ratio = dropdownValue.ratio;
      gelMix = sharedService.gelCalculator(
          RatioImpl(
              maltodextrin: double.parse(maltodextrinController.text),
              fructose: double.parse(fructoseController.text)),
          int.parse(numberGelsController.text),
          int.parse(amountCarbohydratesPerGelsController.text),
          isCheckedFlavoring!,
          isCheckedSalts!,
          dropdownValue.nameDropdown,
          double.parse(flavoringController.text),
          double.parse(saltsController.text),
          double.parse(wantMoreWaterController.text));
    });
  }

  void updateDropdownValue(RatioDropdownButton? newValue) {
    setState(() {
      dropdownValue = newValue!;
    });
  }

  @override
  void initState() {
    super.initState();
    amountCarbohydratesPerGelsController.text =
        amountCarbohydratesPerGels.toString();
    numberGelsController.text = numberGels.toString();
    maltodextrinController.text = ratio.maltodextrin.toString();
    fructoseController.text = ratio.fructose.toString();
    flavoringController.text = '1.0';
    saltsController.text = '1.0';
    wantMoreWaterController.text = '3.0';
    ratioDropdownButtonList = <RatioDropdownButton>[
      RatioDropdownButtonImpl(
          ratio: RatioImpl(maltodextrin: 1, fructose: 0.8),
          nameDropdown: 'Ratio 1:0,8'),
      RatioDropdownButtonImpl(
          ratio: RatioImpl(maltodextrin: 1, fructose: 0.5),
          nameDropdown: 'Ratio 1:0,5'),
      RatioDropdownButtonImpl(
          ratio: RatioImpl(
              maltodextrin: double.parse(maltodextrinController.text),
              fructose: double.parse(fructoseController.text)),
          nameDropdown: 'Ratio personalizado')
    ];
    dropdownValue = ratioDropdownButtonList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 25),
                    CustomDropdownButton(
                      list: ratioDropdownButtonList,
                      selectedValue: dropdownValue,
                      onSelected: updateDropdownValue,
                    ),
                    const SizedBox(height: 25),
                    CustomRow(
                        controller: amountCarbohydratesPerGelsController,
                        title: 'Cantidad de carbohidratos por gel',
                        deltaValue: 1,
                        marginLeft: 15),
                    const SizedBox(height: 15),
                    CustomRow(
                        controller: numberGelsController,
                        title: 'Número de Geles a preparar',
                        deltaValue: 1,
                        marginLeft: 15),
                    if (dropdownValue.nameDropdown ==
                        'Ratio personalizado') ...[
                      const SizedBox(height: 25),
                      CustomRowWithRatio(
                        controller: maltodextrinController,
                        ratio: ratio,
                        title: 'Maltodextrina (%)',
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
                        willBeChangedMaltodextrin: false,
                        deltaValue: 0.1,
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 25,
                      ),
                    ],
                    CustomCheckboxListTile(
                        isChecked: wantMoreWater,
                        title: '¿Quieres cambiar la cantidad de agua por gel?',
                        onChanged: (bool? value) {
                          setState(() {
                            wantMoreWater = value;
                          });
                        }),
                    if (wantMoreWater == true) ...[
                      CustomRowWithRatio(
                        controller: wantMoreWaterController,
                        ratio: ratio,
                        title: 'Cantidad de agua por gel',
                        willBeChangedMaltodextrin: true,
                        deltaValue: 0.1,
                      ),
                      const SizedBox(height: 25)
                    ],
                    CustomCheckboxListTile(
                        isChecked: isCheckedFlavoring,
                        title: '¿Quieres saborizante?',
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedFlavoring = value;
                          });
                        }),
                    if (dropdownValue.nameDropdown == 'Ratio personalizado' &&
                        isCheckedFlavoring == true) ...[
                      CustomRowWithRatio(
                        controller: flavoringController,
                        ratio: ratio,
                        title: 'Saborizante por gel',
                        willBeChangedMaltodextrin: true,
                        deltaValue: 0.1,
                      ),
                      const SizedBox(height: 25)
                    ],
                    CustomCheckboxListTile(
                        isChecked: isCheckedSalts,
                        title: '¿Quieres sales?',
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedSalts = value;
                          });
                        }),
                    if (dropdownValue.nameDropdown == 'Ratio personalizado' &&
                        isCheckedSalts == true) ...[
                      CustomRowWithRatio(
                        controller: saltsController,
                        ratio: ratio,
                        title: 'Sales por gel',
                        willBeChangedMaltodextrin: true,
                        deltaValue: 0.1,
                      )
                    ],
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: gelCalculate,
                      child: const Text('Calcular'),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Card(
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Resultados',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ResultRow(
                      label: 'Gramos de maltodextrina',
                      value: '${gelMix.gramsMaltodextrin.toString()} gramos',
                      icon: Icons.energy_savings_leaf,
                      color: Colors.red,
                      iconSize: 24.0,
                    ),
                    ResultRow(
                      label: 'Gramos de fructosa',
                      value: '${gelMix.gramsFructose.toString()} gramos',
                      icon: Icons.energy_savings_leaf,
                      color: Colors.red,
                      iconSize: 24.0,
                    ),
                    const SizedBox(height: 15),
                    if (isCheckedFlavoring == true) ...[
                      ResultRow(
                        label: 'Gramos de saborizante',
                        value: '${gelMix.flavorings.toString()} gramos',
                        icon: Icons.emoji_food_beverage,
                        color: const Color.fromARGB(255, 11, 187, 14),
                        iconSize: 24.0,
                      ),
                    ],
                    if (isCheckedSalts == true) ...[
                      ResultRow(
                        label: 'Gramos de sales',
                        value: '${gelMix.salts.toString()} gramos',
                        icon: Icons.emoji_food_beverage,
                        color: const Color.fromARGB(255, 11, 187, 14),
                        iconSize: 24.0,
                      ),
                    ],
                    if (isCheckedFlavoring == true ||
                        isCheckedSalts == true) ...[
                      const SizedBox(height: 15),
                    ],
                    ResultRow(
                      label: 'Mililitros de agua',
                      value: '${gelMix.water.toString()} mililitros',
                      icon: Icons.water,
                      color: Colors.blue,
                      iconSize: 24.0,
                    ),
                    const SizedBox(height: 15),
                    ResultRow(
                      label: 'Peso por gel',
                      value: '${gelMix.gelWeight.toString()} gramos',
                      icon: Icons.monitor_weight,
                      color: const Color.fromARGB(255, 223, 182, 18),
                      iconSize: 24.0,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
