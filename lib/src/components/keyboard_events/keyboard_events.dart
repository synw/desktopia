import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'keys.dart' as keys;

class _KeyboardEventsState extends State<KeyboardEvents> {
  _KeyboardEventsState({@required this.child, this.onCtrlEnter});

  final Widget child;
  final VoidCallback onCtrlEnter;

  final _focusNode = FocusNode();

  void _handleKeyEvent(RawKeyEvent event) {
    //final kid = event.logicalKey.keyId;
    //final key = LogicalKeyboardKey.findKeyByKeyId(kid);
    //print("KEY ${key.runtimeType} $key");
    //print("KEY EVENT: $key");
    switch (event.isControlPressed) {
      case true:
        // if (key.runtimeType.toString() == 'RawKeyDownEvent') {
        if (event.isKeyPressed(keys.enter)) {
          if (onCtrlEnter != null) {
            //print("CTRL ENTER");
            // unfocus
            _focusNode.nextFocus();
            onCtrlEnter();
          }
        }
        //}
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: child,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

class KeyboardEvents extends StatefulWidget {
  const KeyboardEvents({@required this.child, this.onCtrlEnter});

  final Widget child;
  final VoidCallback onCtrlEnter;

  @override
  _KeyboardEventsState createState() =>
      _KeyboardEventsState(child: child, onCtrlEnter: onCtrlEnter);
}
