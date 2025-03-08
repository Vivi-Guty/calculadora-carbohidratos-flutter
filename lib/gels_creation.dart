import 'dart:convert';

import 'package:calculadora_de_carbohidratos/login/users.dart';
import 'package:calculadora_de_carbohidratos/models/gel_mix.dart';
import 'package:calculadora_de_carbohidratos/models/ratio.dart';
import 'package:calculadora_de_carbohidratos/models/ratio_dropdown_button.dart';
import 'package:calculadora_de_carbohidratos/services/localization_service.dart';
import 'package:calculadora_de_carbohidratos/shared/base_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/shared_service.dart';
import 'widgets/custom_checkbox_list_tile.dart';
import 'widgets/custom_dropdown_button.dart';
import 'widgets/custom_row.dart';
import 'widgets/custom_row_with_ratio.dart';
import 'widgets/result_row.dart';

class GelsCreation extends BasePage {
  const GelsCreation({super.key, required super.title});

  @override
  Widget pageBody() {
    return const RatioInput();
  }
}

Future<User> _getCachedUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('user');
  if (userJson != null) {
    return User.fromMap(jsonDecode(userJson));
  }
  return User(email: '', username: '', password: '', isPremium: false);
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
  int amountCarbohydratesPerGels = 45;
  GelMix gelMix = GelMixImpl(
      gramsMaltodextrin: 0.0,
      gramsFructose: 0.0,
      gramsProtein: 0.0,
      flavorings: 0.0,
      salts: 0.0,
      water: 0,
      gelWeight: 0);
  Ratio ratio = RatioImpl(maltodextrin: 1, fructose: 0.8);
  SharedService sharedService = SharedService();
  List<RatioDropdownButton> ratioDropdownButtonList = <RatioDropdownButton>[];
  RatioDropdownButton dropdownValue = RatioDropdownButtonImpl(
    nameDropdown: '',
    ratio: RatioImpl(maltodextrin: 1, fructose: 0.8),
  );
  bool? isCheckedFlavoring = false;
  bool? isCheckedSalts = false;
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
          double.parse(wantMoreWaterController.text),
          context);
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
          ratio: RatioImpl(maltodextrin: 1, fructose: 0.8),
          nameDropdown: LocalizationService.of(context)
                      .translate('ratio', '1:0,8Protein') ==
                  'Translation not available'
              ? 'Translation not available 1:0,8 with protein'
              : LocalizationService.of(context).translate('ratio', '1:0,8Protein')),
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
    return FutureBuilder<User>(
      // return Scaffold(
      future: _getCachedUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
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
                              title: LocalizationService.of(context)
                                  .translate('carbohydrates_per_gel'),
                              deltaValue: 1,
                              marginLeft: 15),
                          const SizedBox(height: 15),
                          CustomRow(
                              controller: numberGelsController,
                              title: LocalizationService.of(context)
                                  .translate('gels_to_prepare'),
                              deltaValue: 1,
                              marginLeft: 15),
                          if (dropdownValue.nameDropdown ==
                                  (LocalizationService.of(context)
                                              .translate('ratio', 'custom') ==
                                          'Translation not available'
                                      ? 'Translation not available custom'
                                      : LocalizationService.of(context)
                                          .translate('ratio', 'custom')) &&
                              user.isPremium) ...[
                            const SizedBox(height: 25),
                            CustomRowWithRatio(
                              controller: maltodextrinController,
                              ratio: ratio,
                              title: LocalizationService.of(context).translate(
                                  'maltodextrin_plus_parameter', 'percentage'),
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
                              title: LocalizationService.of(context).translate(
                                  'fructose_plus_parameter', 'percentage'),
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
                              title: LocalizationService.of(context)
                                  .translate('change_water_per_gel_question'),
                              onChanged: (bool? value) {
                                setState(() {
                                  wantMoreWater = value;
                                });
                              }),
                          if (wantMoreWater == true) ...[
                            CustomRowWithRatio(
                              controller: wantMoreWaterController,
                              ratio: ratio,
                              title: LocalizationService.of(context)
                                  .translate('water_per_gel'),
                              willBeChangedMaltodextrin: true,
                              deltaValue: 0.1,
                            ),
                            const SizedBox(height: 25)
                          ],
                          CustomCheckboxListTile(
                              isChecked: isCheckedFlavoring,
                              title: LocalizationService.of(context)
                                  .translate('do_you_want', 'flavoring'),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedFlavoring = value;
                                });
                              }),
                          if (dropdownValue.nameDropdown ==
                                  (LocalizationService.of(context)
                                              .translate('ratio', 'custom') ==
                                          'Translation not available'
                                      ? 'Translation not available custom'
                                      : LocalizationService.of(context)
                                          .translate('ratio', 'custom')) &&
                              isCheckedFlavoring == true &&
                              user.isPremium) ...[
                            CustomRowWithRatio(
                              controller: flavoringController,
                              ratio: ratio,
                              title: LocalizationService.of(context)
                                  .translate('per_gel', 'flavoring'),
                              willBeChangedMaltodextrin: true,
                              deltaValue: 0.1,
                            ),
                            const SizedBox(height: 25)
                          ],
                          CustomCheckboxListTile(
                              isChecked: isCheckedSalts,
                              title: LocalizationService.of(context)
                                  .translate('do_you_want', 'salt'),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedSalts = value;
                                });
                              }),
                          if (dropdownValue.nameDropdown ==
                                  (LocalizationService.of(context)
                                              .translate('ratio', 'custom') ==
                                          'Translation not available'
                                      ? 'Translation not available custom'
                                      : LocalizationService.of(context)
                                          .translate('ratio', 'custom')) &&
                              isCheckedSalts == true &&
                              user.isPremium) ...[
                            CustomRowWithRatio(
                              controller: saltsController,
                              ratio: ratio,
                              title: LocalizationService.of(context)
                                  .translate('per_gel', 'salt'),
                              willBeChangedMaltodextrin: true,
                              deltaValue: 0.1,
                            )
                          ],
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: gelCalculate,
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
                          Text(
                            LocalizationService.of(context)
                                .translate('results'),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          ResultRow(
                            label: LocalizationService.of(context)
                                .translate('grams_of', 'maltodextrin'),
                            value:
                                '${gelMix.gramsMaltodextrin.toString()} ${LocalizationService.of(context).translate('grams', '', true)}',
                            icon: Icons.energy_savings_leaf,
                            color: Colors.red,
                            iconSize: 24.0,
                          ),
                          ResultRow(
                            label: LocalizationService.of(context)
                                .translate('grams_of', 'fructose'),
                            value:
                                '${gelMix.gramsFructose.toString()} ${LocalizationService.of(context).translate('grams', '', true)}',
                            icon: Icons.energy_savings_leaf,
                            color: Colors.red,
                            iconSize: 24.0,
                          ),
                          if (isCheckedFlavoring == true && dropdownValue.nameDropdown == LocalizationService.of(context).translate('ratio', '1:0,8Protein')) ...[
                            ResultRow(
                              label: LocalizationService.of(context)
                                  .translate('grams_of', 'protein'),
                              value:
                                  '${gelMix.gramsProtein.toString()} ${LocalizationService.of(context).translate('grams', '', true)}',
                              icon: Icons.energy_savings_leaf,
                              color: Colors.red,
                              iconSize: 24.0,
                            ),
                          ],
                          const SizedBox(height: 15),
                          if (isCheckedFlavoring == true) ...[
                            ResultRow(
                              label: LocalizationService.of(context)
                                  .translate('grams_of', 'flavoring'),
                              value:
                                  '${gelMix.flavorings.toString()} ${LocalizationService.of(context).translate('grams', '', true)}',
                              icon: Icons.emoji_food_beverage,
                              color: const Color.fromARGB(255, 11, 187, 14),
                              iconSize: 24.0,
                            ),
                          ],
                          if (isCheckedSalts == true) ...[
                            ResultRow(
                              label: LocalizationService.of(context)
                                  .translate('grams_of', 'salt'),
                              value:
                                  '${gelMix.salts.toString()} ${LocalizationService.of(context).translate('grams', '', true)}',
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
                            label: LocalizationService.of(context)
                                .translate('water_ml'),
                            value:
                                '${gelMix.water.toString()} ${LocalizationService.of(context).translate('milliliters', '', true)}',
                            icon: Icons.water,
                            color: Colors.blue,
                            iconSize: 24.0,
                          ),
                          const SizedBox(height: 15),
                          ResultRow(
                            label: LocalizationService.of(context)
                                .translate('per_gel', 'weight'),
                            value:
                                '${gelMix.gelWeight.toString()} ${LocalizationService.of(context).translate('grams', '', true)}',
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
        } else {
          return const Center(child: Text('No user data'));
        }
      },
    );
  }
}
