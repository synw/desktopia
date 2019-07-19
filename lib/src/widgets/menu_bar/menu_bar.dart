import 'package:flutter/material.dart';
import 'models.dart';

class _MenuBarState extends State<MenuBar> {
  _MenuBarState(this.menu, {this.height = 35.0});

  final MenuBarData menu;
  final double height;

  bool _isSubMenuActive = false;

  List<Widget> buildMenu() {
    final wl = <Widget>[];
    for (final MenuItem menuItem in menu.menuItems) {
      wl.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Text("${menuItem.title}",
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    if (menuItem.subMenu == null) {
                      menuItem.action();
                    } else {
                      setState(() => _isSubMenuActive = !_isSubMenuActive);
                    }
                  },
                ),
                if (menuItem.subMenu != null)
                  _isSubMenuActive
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: GestureDetector(
                            child: Text(menuItem.title),
                            onTap: () => menuItem.action,
                          ))
                      : const Text("")
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

/// A top menu bar
class MenuBar extends StatefulWidget {
  /// Default contructor
  MenuBar(this.menu);

  /// The menu data
  final MenuBarData menu;

  @override
  _MenuBarState createState() => _MenuBarState(menu);
}
