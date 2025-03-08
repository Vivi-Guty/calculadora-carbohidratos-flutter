import 'package:calculadora_de_carbohidratos/models/carbohydrate_ratio.dart';
import 'package:calculadora_de_carbohidratos/models/ratio.dart';
import 'package:calculadora_de_carbohidratos/models/ratio_dropdown_button.dart';
import 'package:calculadora_de_carbohidratos/services/localization_service.dart';
import 'package:calculadora_de_carbohidratos/services/shared_service.dart';
import 'package:calculadora_de_carbohidratos/shared/base_page.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_dropdown_button.dart';
import 'widgets/custom_row.dart';
import 'widgets/custom_row_with_ratio.dart';
import 'widgets/result_row.dart';

class CreationIsotonicDrink extends BasePage {
  const CreationIsotonicDrink({super.key, required super.title});

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
  List<RatioDropdownButton> ratioDropdownButtonList = <RatioDropdownButton>[];
  RatioDropdownButton dropdownValue = RatioDropdownButtonImpl(
    nameDropdown: '',
    ratio: RatioImpl(maltodextrin: 1, fructose: 0.8),
  );

  void calculate() {
    setState(() {
      if (dropdownValue.nameDropdown == 'Ratio personalizado') {
        ratio = RatioImpl(
            maltodextrin: double.parse(maltodextrinController.text),
            fructose: double.parse(fructoseController.text));
      } else {
        ratio = dropdownValue.ratio;
      }
      carbohydrates = sharedService.calculateCarbohydrates(
          int.parse(mlController.text),
          int.parse(concentrationController.text),
          RatioImpl(
              maltodextrin: ratio.maltodextrin, fructose: ratio.fructose));
    });
  }

  void updateDropdownValue(RatioDropdownButton? newValue) {
    setState(() {
      dropdownValue = newValue!;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mlController.text = ml.toString();
    concentrationController.text = concentration.toString();
    maltodextrinController.text = ratio.maltodextrin.toString();
    fructoseController.text = ratio.fructose.toString();
    ratioDropdownButtonList = <RatioDropdownButton>[
      RatioDropdownButtonImpl(
          ratio: RatioImpl(maltodextrin: 1, fructose: 0.8),
          nameDropdown: LocalizationService.of(context)
                      .translate('ratio', '1:0,8') ==
                  'Translation not available'
              ? 'Translation not available 1:0,8'
              : LocalizationService.of(context).translate('ratio', '1:0,8')),
      RatioDropdownButtonImpl(
          ratio: RatioImpl(maltodextrin: 1, fructose: 0.5),
          nameDropdown: LocalizationService.of(context).translate('basic') ==
                  'Translation not available'
              ? 'Translation not available basic'
              : LocalizationService.of(context).translate('basic')),
      RatioDropdownButtonImpl(
          ratio: RatioImpl(
              maltodextrin: double.parse(maltodextrinController.text),
              fructose: double.parse(fructoseController.text)),
          nameDropdown: LocalizationService.of(context)
                      .translate('ratio', 'custom') ==
                  'Translation not available'
              ? 'Translation not available custom'
              : LocalizationService.of(context).translate('ratio', 'custom'))
    ];
    dropdownValue = ratioDropdownButtonList[1];
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
                    CustomRow(
                      controller: mlController,
                      title: LocalizationService.of(context)
                          .translate('drink_volume'),
                      magnitude: LocalizationService.of(context)
                          .translate('ml', '', true),
                      marginLeft: 15,
                    ),
                    if (dropdownValue.nameDropdown ==
                        (LocalizationService.of(context)
                                    .translate('ratio', 'custom') ==
                                'Translation not available'
                            ? 'Translation not available custom'
                            : LocalizationService.of(context)
                                .translate('ratio', 'custom'))) ...[
                      const SizedBox(height: 25),
                      CustomRow(
                        controller: concentrationController,
                        title: LocalizationService.of(context)
                            .translate('drink_concentration'),
                        magnitude: '%',
                        marginLeft: 15,
                        deltaValue: 1,
                      ),
                      const SizedBox(height: 25),
                      CustomRowWithRatio(
                        controller: maltodextrinController,
                        ratio: ratio,
                        title: LocalizationService.of(context)
                            .translate('grams_of', 'maltodextrin'),
                        willBeChangedMaltodextrin: true,
                        deltaValue: 0.1,
                      ),
                      const SizedBox(height: 25),
                      CustomRowWithRatio(
                        controller: fructoseController,
                        ratio: ratio,
                        title: LocalizationService.of(context)
                            .translate('grams_of', 'fructose'),
                        willBeChangedMaltodextrin: false,
                        deltaValue: 0.1,
                      )
                    ],
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: calculate,
                      child: Text(LocalizationService.of(context)
                          .translate('calculate')),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Card(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 25),
                    Text(
                      LocalizationService.of(context).translate('results'),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ResultRow(
                      label: LocalizationService.of(context)
                          .translate('grams_of', 'maltodextrin'),
                      value:
                          '${carbohydrates.gramsMaltodextrin.toString()} ${LocalizationService.of(context).translate('grams', '', true)}',
                      icon: Icons.energy_savings_leaf,
                      color: Colors.red,
                      iconSize: 24.0,
                    ),
                    ResultRow(
                      label: LocalizationService.of(context)
                          .translate('grams_of', 'fructose'),
                      value:
                          '${carbohydrates.gramsFructose.toString()} ${LocalizationService.of(context).translate('grams', '', true)}',
                      icon: Icons.energy_savings_leaf,
                      color: Colors.red,
                      iconSize: 24.0,
                    ),
                    const SizedBox(height: 25),
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
