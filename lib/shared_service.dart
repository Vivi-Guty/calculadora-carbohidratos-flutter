abstract class CarbohydrateRatio {
  double get gramsMaltodextrin;
  double get gramsFructose;
}

abstract class Ratio {
  double get maltodextrin;
  double get fructose;
}

class SharedService {
  CarbohydrateRatio calculateCarbohydrates(
      int ml, int concentration, Ratio ratio) {
    double totalCarbohydrate = ml * (concentration / 100);
    double partsTotals = ratio.maltodextrin + ratio.fructose;

    return CarbohydrateRatioImpl(
      gramsMaltodextrin:
          (totalCarbohydrate * (ratio.maltodextrin / partsTotals)),
      gramsFructose: (totalCarbohydrate * (ratio.fructose / partsTotals)),
    );
  }
}

class CarbohydrateRatioImpl implements CarbohydrateRatio {
  @override
  final double gramsMaltodextrin;
  @override
  final double gramsFructose;

  CarbohydrateRatioImpl(
      {required this.gramsMaltodextrin, required this.gramsFructose});
}

class RatioImpl implements Ratio {
  @override
  final double maltodextrin;
  @override
  final double fructose;

  RatioImpl({required this.maltodextrin, required this.fructose});
}
