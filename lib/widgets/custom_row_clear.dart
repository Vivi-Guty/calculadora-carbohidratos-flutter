import 'package:flutter/material.dart';
import '../services/controller_service.dart';

class CustomRowClear extends StatelessWidget {
  final TextEditingController controller;
  final ControllerService controllerService = ControllerService();
  final String title;

  CustomRowClear({super.key, required this.controller, this.title = 'Limpiar'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 70,
            child: TextButton(
              onPressed: () {
                controllerService.clear(controller);
              },
              child: Text(title),
            ),
          ),
        ),
      ],
    );
  }
}
