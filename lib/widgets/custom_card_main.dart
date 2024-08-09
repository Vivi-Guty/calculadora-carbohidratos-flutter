import 'package:flutter/material.dart';

class CustomCardMain extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Text title;
  final Text subtitle;
  final double padding;
  final double left;
  final double top;
  final double right;
  final double bottom;

  CustomCardMain({
    required this.title,
    required this.subtitle,
    this.icon,
    this.iconColor,
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
          children: <Widget>[
            ListTile(
              leading: Icon(icon),
              iconColor: iconColor,
              title: title,
              subtitle: subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
