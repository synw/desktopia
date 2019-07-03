import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MenuBarData {
  MenuBarData({@required this.menuItems});

  final List<MenuItem> menuItems;
}

class MenuItem {
  MenuItem(
      {@required this.title,
      @required this.context,
      this.actionMenu,
      this.action});

  final String title;
  final BuildContext context;
  final ActionMenu actionMenu;
  final VoidCallback action;
}

class ActionMenu {
  ActionMenu({this.actions});

  final List<MenuAction> actions;
}

class MenuAction {
  MenuAction({@required this.title, @required this.onPressed});

  final String title;
  final VoidCallback onPressed;
}
