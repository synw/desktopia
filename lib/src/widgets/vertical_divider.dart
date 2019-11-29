import 'package:flutter/material.dart';

/// A vertical divider
class DesktopVerticalDivider extends StatelessWidget {
  /// The default color is grey
  const DesktopVerticalDivider(
      {this.width = 3.0, this.color = const Color(0xffcecece)});

  /// The width of the divider
  final double width;

  /// The color of the divider
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(width: width, color: color);
  }
}
