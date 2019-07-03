import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'zone.dart';

class ScreenZones {
  ScreenZones({@required this.children, @required this.updates});

  final Map<String, ScreenZone> children;

  final StreamController<ScreenZoneUpdate> updates;

  void pushChild(String name, Widget _widget) {
    //print("Push child $_widget in $name");
    assert(name != null);
    assert(_widget != null);
    if (!children.containsKey(name)) throw ("Screen zone $name not found");
    updates.sink.add(ScreenZoneUpdate(name: name, child: _widget));
  }

  ScreenZone getZone(String name) {
    assert(name != null);
    if (!children.containsKey(name)) throw ("Screen zone $name not found");
    ScreenZone zone = children[name];
    return zone;
  }

  dispose() => updates.close();
}

class ScreenZoneUpdate {
  ScreenZoneUpdate({@required this.name, @required this.child});

  final String name;
  final Widget child;
}
