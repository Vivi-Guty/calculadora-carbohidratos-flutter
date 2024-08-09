import 'package:flutter/material.dart';

class PersonalizedCardMultiple extends StatelessWidget {
  final List<ListTile> listTiles;
  final double padding;
  final double left;
  final double top;
  final double right;
  final double bottom;

  const PersonalizedCardMultiple({
    super.key,
    required this.listTiles,
    this.padding = 16.0,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == 0
          ? EdgeInsets.only(
              left: left,
              top: top,
              right: right,
              bottom: bottom,
            )
          : EdgeInsets.symmetric(vertical: padding),
      child: Card(
        child: Column(
          children: listTiles,
        ),
      ),
    );
  }
}
