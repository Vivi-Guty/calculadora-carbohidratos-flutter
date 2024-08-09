abstract class Ratio {
  double get maltodextrin;
  double get fructose;
}

class RatioImpl implements Ratio {
  @override
  final double maltodextrin;
  @override
  final double fructose;

  RatioImpl({required this.maltodextrin, required this.fructose});
}
