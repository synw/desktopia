import 'package:flutter/material.dart';
import 'models.dart';

class _MenuBarState extends State<MenuBar> {
  _MenuBarState(this.menu, {this.height = 35.0});

  final MenuBarData menu;
  final double height;

  List<Widget> buildMenu() {
    var wl = <Widget>[];
    for (final MenuItem menuItem in menu.menuItems) {
      wl.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Text("${menuItem.title}",
                      style: TextStyle(color: Colors.black)),
                  onTap: () => menuItem.action(),
                ),
                /*if (menuItem.actionMenu != null)
              Stack(
                children: <Widget>[],
              )*/
              ])));
    }
    return wl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xffcecece),
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: buildMenu()),
        ));
  }
}

class MenuBar extends StatefulWidget {
  MenuBar(this.menu);

  final MenuBarData menu;

  @override
  _MenuBarState createState() => _MenuBarState(menu);
}
