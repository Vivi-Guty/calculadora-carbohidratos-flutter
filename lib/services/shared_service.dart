import 'package:calculadora_de_carbohidratos/services/localization_service.dart';
import 'package:flutter/material.dart';

import '../models/carbohydrate_ratio.dart';
import '../models/gel_mix.dart';
import '../models/ratio.dart';

class SharedService {
  
  CarbohydrateRatio calculateCarbohydrates(
      int ml, int concentration, Ratio ratio) {
    double totalCarbohydrate = ml * (concentration / 100);
    double partsTotals = ratio.maltodextrin + ratio.fructose;

    return CarbohydrateRatioImpl(
      gramsMaltodextrin: double.parse(
          (totalCarbohydrate * (ratio.maltodextrin / partsTotals))
              .toStringAsFixed(2)),
      gramsFructose: double.parse(
          (totalCarbohydrate * (ratio.fructose / partsTotals))
              .toStringAsFixed(2)),
    );
  }
  
  GelMixImpl gelCalculator(
      Ratio ratio,
      int numberGels,
      int amountCarbohydratesPerGels,
      bool isCheckedFlavoring,
      bool isCheckedSalts,
      String nameDropdown,
      double flavoringForGel,
      double saltsForGel,
      double saltwantMoreWater,
      BuildContext context) {
    int totalMix = 1000;
    double mixingRatio = double.parse(
        (amountCarbohydratesPerGels / totalMix).toStringAsFixed(2));
    int flavoringsAndSalts = 100;
    int water = 0;
    double maltodextrinForGel = double.parse(
        (amountCarbohydratesPerGels / (ratio.maltodextrin + ratio.fructose))
            .toStringAsFixed(2));
    double fructoseForGel = maltodextrinForGel * ratio.fructose;

    double proteinForGel = nameDropdown == LocalizationService.of(context).translate('ratio', '1:0,8Protein') ? (maltodextrinForGel + fructoseForGel) / 3.5 : 0;
    double flavorings = isCheckedFlavoring
        ? (nameDropdown != LocalizationService.of(context).translate('ratio', 'custom')
            ? double.parse(
                ((flavoringsAndSalts / 2) * mixingRatio).toStringAsFixed(2))
            : flavoringForGel)
        : 0;
    double salts = isCheckedSalts
        ? (nameDropdown != LocalizationService.of(context).translate('ratio', 'custom')
            ? double.parse(
                ((flavoringsAndSalts / 2) * mixingRatio).toStringAsFixed(2))
            : saltsForGel)
        : 0;

    water = int.parse(
        (((maltodextrinForGel + fructoseForGel+ proteinForGel + flavorings + salts) *
                    numberGels) /
                saltwantMoreWater)
            .toStringAsFixed(0));
    
    return GelMixImpl(
      gramsMaltodextrin:
          double.parse((maltodextrinForGel * numberGels).toStringAsFixed(2)),
      gramsFructose:
          double.parse((fructoseForGel * numberGels).toStringAsFixed(2)),
      gramsProtein: double.parse((proteinForGel * numberGels).toStringAsFixed(2)),
      flavorings: flavorings * numberGels,
      salts: salts * numberGels,
      water: water,
      gelWeight: double.parse((maltodextrinForGel +
              fructoseForGel +
              proteinForGel +
              flavorings +
              salts +
              (water / numberGels))
          .toStringAsFixed(2)),
    );
  }
}
