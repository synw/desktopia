import 'package:flutter/material.dart';

class DesktopSectionHeader extends StatelessWidget {
  DesktopSectionHeader(
      {@required this.title,
      this.color = const Color(0xffcecece),
      this.borderTop = true});

  final String title;
  final Color color;
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
