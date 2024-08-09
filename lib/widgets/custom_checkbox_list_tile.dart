import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final bool? isChecked;
  final String title;
  final Color checkColor;
  final Color fillColorIsChecked;
  final Color fillColorIsNotChecked;
  final ValueChanged<bool?>? onChanged;

  const CustomCheckboxListTile({
    super.key,
    required this.isChecked,
    required this.title,
    required this.onChanged,
    this.checkColor = Colors.black,
    this.fillColorIsChecked = Colors.green,
    this.fillColorIsNotChecked = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      controlAffinity: ListTileControlAffinity.leading,
      value: isChecked,
      checkColor: checkColor,
      fillColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (isChecked == true) {
          return fillColorIsChecked;
        }
        return fillColorIsNotChecked;
      }),
      onChanged: onChanged,
    );
  }
}
