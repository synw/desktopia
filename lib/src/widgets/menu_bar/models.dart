import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// The data for the menu
class MenuBarData {
  /// Provide the menu items
  MenuBarData({@required this.menuItems});

  /// The menu items
  final List<MenuItem> menuItems;
}

/// A single menu item
class MenuItem {
  /// Provide title and context
  MenuItem(
      {@required this.title,
      @required this.context,
      this.action,
      this.subMenu}) {
    action ??= () => null;
  }

  /// The tile of the menu item
  final String title;

  /// Build context
  final BuildContext context;

  /// The menu action to perform on click
  VoidCallback action;

  /// The submenu data
  final SubMenu subMenu;
}

/// A submenu that pops up on click
class SubMenu {
  /// Provide actions
  SubMenu({this.actions});

  /// The submenu actions
  final List<MenuAction> actions;
}

/// An action to perform on click
class MenuAction {
  /// Provide a title and a function to run
  MenuAction({@required this.title, @required this.onPressed});

  /// The menu title
  final String title;

  /// The action to perform on click
  final VoidCallback onPressed;
}
