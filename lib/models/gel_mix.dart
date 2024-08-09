abstract class GelMix {
  double get gramsMaltodextrin;
  double get gramsFructose;
  double get flavorings;
  double get salts;
  int get water;
  double get gelWeight;
  double get wantMoreWater;
}

class GelMixImpl implements GelMix {
  @override
  final double gramsMaltodextrin;
  @override
  final double gramsFructose;
  @override
  final double flavorings;
  @override
  final double salts;
  @override
  final int water;
  @override
  final double gelWeight;
  @override
  final double wantMoreWater;

  GelMixImpl({
    required this.gramsMaltodextrin,
    required this.gramsFructose,
    required this.flavorings,
    required this.salts,
    required this.water,
    required this.gelWeight,
    this.wantMoreWater = 3.0,
  });
}
