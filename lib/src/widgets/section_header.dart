import 'package:flutter/material.dart';

/// A section header for sidebars
class DesktopSectionHeader extends StatelessWidget {
  /// Provide a title
  const DesktopSectionHeader(
      {@required this.title,
      this.color = const Color(0xffcecece),
      this.borderTop = true});

  /// The section title
  final String title;

  /// The color of the section header
  final Color color;

  /// Use a border on top
  final bool borderTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (borderTop)
          Container(
              height: 1.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[400],
              child: const Text("")),
        Container(
            color: color,
            child: Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Text(title, textScaleFactor: 1.2))
              ],
            ))
      ],
    );
  }
}
