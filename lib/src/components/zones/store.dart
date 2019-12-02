import 'dart:async';

import 'package:flutter/material.dart';

import 'models.dart';
import 'state.dart';

/// The app zones state
///
/// Use this when you want to access the app zones
/// state without a context
final AppZoneState appZoneState = AppZoneState();

final _appZoneStateUpdateController = StreamController<AppZoneStore>();

/// The state updates stream
Stream<AppZoneStore> appZoneStateStream = _appZoneStateUpdateController.stream;

/// The function to update a zone with a new widget
void updateAppZone(AppZone zone, Widget widget) =>
    _appZoneStateUpdateController.sink
        .add(AppZoneStore.updateZone(zone, widget));

/// The store that manage state mutations
class AppZoneStore {
  /// Main constructor
  AppZoneStore();

  /// The zones state
  final AppZoneState state = appZoneState;

  /// Is the store ready
  ///
  /// If not run [init] before using
  bool get isReady => state.isReady;

  /// Initialize the store: run this before using
  void init(List<AppZone> zones) {
    assert(zones != null);
    assert(zones.isNotEmpty);
    print("Initializing app zones");
    state
      ..zones = zones
      ..isReady = true;
    print("Appzones initialized");
  }

  /// Access the current widget of a zone
  Widget widgetForZone(String name) {
    Widget w;
    for (final z in state.zones) {
      if (z.name == name) {
        w = z.widget;
        break;
      }
    }
    assert(w != null, "Can not find widget for zone $name");
    return w;
  }

  /// The store update constructor
  AppZoneStore.updateZone(AppZone zone, Widget widget) {
    assert(
        state.isReady,
        "The app zones store is not ready: please run init() "
        "on the store before using it");
    final newZones = <AppZone>[];
    for (final z in state.zones) {
      if (z.name == zone.name) {
        z.widget = widget;
      }
      newZones.add(z);
    }
    state.zones = newZones;
  }

  /// The main update function
  void update(String name, Widget widget) {
    AppZone zone;
    for (final z in state.zones) {
      if (z.name == name) {
        zone = z;
      }
    }
    assert(zone != null, "Did not find zone $name");
    print("Updating zone $name");
    updateAppZone(zone, widget);
  }

  /// The stream of zones change
  static Stream<AppZoneStore> stream() {
    return _appZoneStateUpdateController.stream;
  }
}
