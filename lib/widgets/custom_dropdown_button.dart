import 'package:flutter/material.dart';
import '../models/ratio_dropdown_button.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<RatioDropdownButton> list;
  final RatioDropdownButton? selectedValue;
  final ValueChanged<RatioDropdownButton?> onSelected;

  const CustomDropdownButton({
    super.key,
    required this.list,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<RatioDropdownButton>(
      initialSelection: selectedValue,
      dropdownMenuEntries: list.map<DropdownMenuEntry<RatioDropdownButton>>(
          (RatioDropdownButton value) {
        return DropdownMenuEntry<RatioDropdownButton>(
            value: value, label: value.nameDropdown);
      }).toList(),
      onSelected: onSelected,
    );
  }
}
