import 'package:flutter/material.dart';

abstract class CarbohydrateRatio {
  double get gramsMaltodextrin;
  double get gramsFructose;
}

abstract class Ratio {
  double get maltodextrin;
  double get fructose;
}

class SharedService {
  CarbohydrateRatio calculateCarbohydrates(
      int ml, int concentration, Ratio ratio) {
    double totalCarbohydrate = ml * (concentration / 100);
    double partsTotals = ratio.maltodextrin + ratio.fructose;

    return CarbohydrateRatioImpl(
      gramsMaltodextrin:
          (totalCarbohydrate * (ratio.maltodextrin / partsTotals)),
      gramsFructose: (totalCarbohydrate * (ratio.fructose / partsTotals)),
    );
  }
}

class ControllerService {
  void increment(TextEditingController controller, int incrementValue) {
    int currentValue = int.tryParse(controller.text) ?? 0;
    currentValue += incrementValue;
    controller.text = currentValue.toString();
  }

  void decrement(TextEditingController controller, int decrementValue) {
    int currentValue = int.tryParse(controller.text) ?? 0;
    if (currentValue - decrementValue >= 0) {
      currentValue -= decrementValue;
      controller.text = currentValue.toString();
    }
  }

  void clear(TextEditingController controller) {
    controller.text = 0.toString();
  }
}

class CarbohydrateRatioImpl implements CarbohydrateRatio {
  @override
  final double gramsMaltodextrin;
  @override
  final double gramsFructose;

  CarbohydrateRatioImpl(
      {required this.gramsMaltodextrin, required this.gramsFructose});
}

class RatioImpl implements Ratio {
  @override
  final double maltodextrin;
  @override
  final double fructose;

  RatioImpl({required this.maltodextrin, required this.fructose});
}
