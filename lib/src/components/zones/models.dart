import 'package:flutter/material.dart';

/// The main app zone class
class AppZone {
  /// Provide a name and an initial widget
  AppZone(this.name, this.widget);

  /// The name of the zone
  final String name;

  /// The initial widget to populate the zone with
  Widget widget;
}
