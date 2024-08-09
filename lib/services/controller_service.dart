import 'package:flutter/material.dart';

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
