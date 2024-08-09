import 'package:flutter/material.dart';

class ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final double iconSize;

  const ResultRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color = Colors.black,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(icon, color: color, size: iconSize),
        ),
        Expanded(
          child: Text(
            '$label: $value',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
