import 'package:flutter/material.dart';

class DesktopVerticalDivider extends StatelessWidget {
  DesktopVerticalDivider(
      {this.width = 3.0, this.color = const Color(0xffcecece)});

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(width: width, color: color);
  }
}
