import 'package:flutter/material.dart';

class CustomPaddingWithText extends StatelessWidget {
  final Text text;
  final double padding;

  const CustomPaddingWithText(
      {super.key, required this.text, this.padding = 30.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: text,
    );
  }
}
