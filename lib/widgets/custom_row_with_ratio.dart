import 'package:flutter/material.dart';
import '../models/ratio.dart';

// ignore: must_be_immutable
class CustomRowWithRatio extends StatelessWidget {
  final TextEditingController controller;
  Ratio ratio;
  final String title;
  final String magnitude;
  final double heightIcon;
  final double sizeIcon;
  final double marginLeft;
  final double whidthTextField;
  final double deltaValue;
  final bool willBeChangedMaltodextrin;
  double lastMaltodextrin;
  double lastFructose;

  CustomRowWithRatio({
    super.key,
    required this.controller,
    required this.ratio,
    required this.willBeChangedMaltodextrin,
    this.title = '',
    this.magnitude = '',
    this.deltaValue = 1.0,
    this.sizeIcon = 35,
    this.heightIcon = 60,
    this.marginLeft = 20,
    this.whidthTextField = 200,
    this.lastMaltodextrin = 1.0,
    this.lastFructose = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: heightIcon,
                child: IconButton(
                  icon: Icon(Icons.remove, color: Colors.red, size: sizeIcon),
                  onPressed: () {
                    if (willBeChangedMaltodextrin) {
                      ratio = RatioImpl(
                          maltodextrin: double.parse(
                              (double.parse(controller.text) - deltaValue)
                                  .toStringAsFixed(2)),
                          fructose: ratio.fructose);
                      controller.text = ratio.maltodextrin.toString();
                    } else {
                      ratio = RatioImpl(
                          maltodextrin: ratio.maltodextrin,
                          fructose: double.parse(
                              (double.parse(controller.text) - deltaValue)
                                  .toStringAsFixed(2)));
                      controller.text = ratio.fructose.toString();
                    }
                  },
                ),
              ),
              SizedBox(width: marginLeft),
              SizedBox(
                width: whidthTextField,
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      controller.text = '';
                      return;
                    } else if (value.isEmpty ||
                        double.tryParse(value) == null) {
                      controller.text = willBeChangedMaltodextrin
                          ? lastMaltodextrin.toString()
                          : lastFructose.toString();
                      return;
                    }
                    double doubleValue = double.tryParse(value) ?? 0.0;
                    if (willBeChangedMaltodextrin) {
                      ratio = RatioImpl(
                          maltodextrin:
                              double.parse(doubleValue.toStringAsFixed(2)),
                          fructose: ratio.fructose);
                      lastMaltodextrin = doubleValue;
                    } else {
                      ratio = RatioImpl(
                          maltodextrin: ratio.maltodextrin,
                          fructose:
                              double.parse(doubleValue.toStringAsFixed(2)));
                      lastFructose = doubleValue;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: title,
                  ),
                ),
              ),
              SizedBox(width: marginLeft),
              SizedBox(
                height: heightIcon,
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.green, size: sizeIcon),
                  onPressed: () {
                    if (willBeChangedMaltodextrin) {
                      ratio = RatioImpl(
                          maltodextrin: double.parse(
                              (double.parse(controller.text) + deltaValue)
                                  .toStringAsFixed(2)),
                          fructose: ratio.fructose);
                      controller.text = ratio.maltodextrin.toString();
                    } else {
                      ratio = RatioImpl(
                          maltodextrin: ratio.maltodextrin,
                          fructose: double.parse(
                              (double.parse(controller.text) + deltaValue)
                                  .toStringAsFixed(2)));
                      controller.text = ratio.fructose.toString();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
