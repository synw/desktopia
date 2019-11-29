import 'dart:async';

import 'package:flutter/material.dart';

import 'models.dart';
import 'state.dart';

final AppZoneState appZoneState = AppZoneState();

final _appZoneStateUpdateController = StreamController<AppZoneStore>();

Stream<AppZoneStore> appZoneStateStream = _appZoneStateUpdateController.stream;

void updateAppZone(AppZone zone, Widget widget) =>
    _appZoneStateUpdateController.sink
        .add(AppZoneStore.updateZone(zone, widget));

class AppZoneStore {
  AppZoneStore();

  final state = appZoneState;

  bool get isReady => state.isReady;

  //Future get onReady => _readyCompleter.future;

  void init(List<AppZone> zones) {
    assert(zones != null);
    assert(zones.isNotEmpty);
    print("Initializing app zones");
    state
      ..zones = zones
      ..isReady = true;
    print("Appzones initialized");
  }

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

  static Stream<AppZoneStore> stream() {
    return _appZoneStateUpdateController.stream;
  }
}
