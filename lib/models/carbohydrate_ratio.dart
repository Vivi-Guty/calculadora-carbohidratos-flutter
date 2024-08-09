abstract class CarbohydrateRatio {
  double get gramsMaltodextrin;
  double get gramsFructose;
}

class CarbohydrateRatioImpl implements CarbohydrateRatio {
  @override
  final double gramsMaltodextrin;
  @override
  final double gramsFructose;

  CarbohydrateRatioImpl({
    required this.gramsMaltodextrin,
    required this.gramsFructose,
  });
}
