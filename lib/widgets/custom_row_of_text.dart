import 'package:flutter/material.dart';

class CustomRowOfText extends StatelessWidget {
  final Text text;
  final IconData icon;
  final Color color;
  final double iconSize;

  const CustomRowOfText({
    super.key,
    required this.text,
    required this.icon,
    this.color = Colors.black,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: iconSize),
        const SizedBox(width: 8),
        text,
      ],
    );
  }
}
