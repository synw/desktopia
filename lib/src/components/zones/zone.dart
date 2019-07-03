import 'dart:async';
import 'package:flutter/material.dart';
import 'zones.dart';

class _ScreenZoneState extends State<ScreenZone> {
  _ScreenZoneState(
      {@required this.name, @required this.child, @required this.updates})
      : assert(updates != null),
        assert(child != null),
        assert(name != null);

  Widget child;
  final String name;

  Stream<ScreenZoneUpdate> updates;
  Completer _readyCompleter = Completer<Null>();

  Future get onReady => _readyCompleter.future;

  @override
  void initState() {
    //print("init zone $name");
    updates.listen((data) {
      if (data.name == name) {
        setState(() => child = data.child);
        //print('UI update ${data.name}: ${data.child}');
      }
    });
    _readyCompleter.complete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(child: child);
}

class ScreenZone extends StatefulWidget {
  ScreenZone(
      {@required this.name, this.children, this.child, @required this.updates});

  final Set<ScreenZone> children;
  final Widget child;
  final String name;
  final Stream<ScreenZoneUpdate> updates;

  @override
  _ScreenZoneState createState() =>
      _ScreenZoneState(name: name, child: child, updates: updates);
}
