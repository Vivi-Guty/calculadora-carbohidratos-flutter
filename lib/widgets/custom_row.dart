import 'package:flutter/material.dart';
import '../services/controller_service.dart';

// ignore: must_be_immutable
class CustomRow extends StatelessWidget {
  final TextEditingController controller;
  final ControllerService controllerService = ControllerService();
  final String title;
  final String magnitude;
  final double heightIcon;
  final double sizeIcon;
  final double marginLeft;
  final double whidthTextField;
  final int deltaValue;
  int lastValue = 0;

  CustomRow({
    super.key,
    required this.controller,
    this.title = '',
    this.magnitude = '',
    this.deltaValue = 50,
    this.sizeIcon = 35,
    this.heightIcon = 60,
    this.marginLeft = 20,
    this.whidthTextField = 200,
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
                    controllerService.decrement(controller, deltaValue);
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
                    } else if (int.tryParse(value) == null) {
                      controller.text = lastValue.toString();
                      return;
                    }
                    int intValue = int.tryParse(value) ?? lastValue;
                    lastValue = intValue;
                    controller.text = intValue.toString();
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: title,
                    suffix: Text(" " + magnitude),
                  ),
                ),
              ),
              SizedBox(width: marginLeft),
              SizedBox(
                height: heightIcon,
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.green, size: sizeIcon),
                  onPressed: () {
                    controllerService.increment(controller, deltaValue);
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
