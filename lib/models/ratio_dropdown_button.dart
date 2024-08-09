import 'ratio.dart';

abstract class RatioDropdownButton {
  String get nameDropdown;
  Ratio get ratio;
}

class RatioDropdownButtonImpl implements RatioDropdownButton {
  @override
  final String nameDropdown;
  @override
  final Ratio ratio;

  RatioDropdownButtonImpl({required this.nameDropdown, required this.ratio});
}
