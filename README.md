# Desktopia

[![pub package](https://img.shields.io/pub/v/desktopia.svg)](https://pub.dartlang.org/packages/desktopia)

Flutter widgets and components for desktop:

- **Configuration manager**: config file management
- **App zones**: a solution for managing the navigation for desktop
- **Widgets**: utility widgets: menu, header, divider

## Components

### Config manager

Load and save config files

   ```dart
   ConfigManager conf = ConfigManager.auto("my_app")..read();
   ```

This will read the config file for the app at `~/.my_app` or create it.
Get the config data

   ```dart
   final Map<String, dynamic> data = conf.data;
   ```

Write the config data:

   ```dart
   conf.data["my_key"] = "my value";
   conf.write(conf.data);
   ```

Get a value from a key:

   ```dart
   final value = conf.key("my_key");
   ```

### Navigation: app zones

A solution for managing navigation inside the desktop app. The pages navigation
paradigm used on mobile do not work well on desktop. This navigation system
defines app zones and update them on demand. App zones are local blocks like
sidebar, icons bar, menu bar or main zone.

#### Create the zones

 Define some zones: create a `zones` directory with the desired zones: ex:

   ```bash
   appbar.dart
   main.dart
   menu.dart
   sidebar.dart
   ```

Create the widgets for the zones: ex `zones/main.dart`:

   ```dart
   import 'package:flutter/material.dart';
   
   class _MainZoneState extends State<MainZone> {
      @override
       Widget build(BuildContext context) {
          return Container(
             child: const Text("Main zone"),
          );
      }
   }
   
   class MainZone extends StatefulWidget {
      @override
      _MainZoneState createState() => _MainZoneState();
   }
   ```

For a full example check [desktop base](https://github.com/synw/desktop_base)

#### Declare the zones

In `zones/appzones.dart`:

   ```dart
   import 'package:desktopia/desktopia.dart';
   import 'package:flutter/widgets.dart';
   
   import 'appbar.dart';
   import 'main.dart';
   
   const Widget emptyWidget = Text("");
   
   final List<AppZone> appZones = <AppZone>[
      AppZone("main", MainZone()),
      AppZone("sidebar", emptyWidget),
      AppZone("appBar", AppBarZone()),
      AppZone("status", emptyWidget),
   ];
   ```

#### Initialize the zones

   ```dart
   import 'package:desktopia/desktopia.dart';
   import 'zones/appzones.dart';

   final AppZoneStore zones = AppZoneStore();
   zones.init(appZones);
   ```

#### Create the main page

Example of main page:

   ```dart
  @override
  Widget build(BuildContext context) {
    final zStore = Provider.of<AppZoneStore>(context);
    return Scaffold(
        body: _ready
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                        color: const Color(0xffcecece),
                        child: Column(children: <Widget>[
                          MenuBar(MenuBarData(menuItems: <MenuItem>[
                            MenuItem(
                                context: context,
                                title: "About",
                                action: () => aboutDialog(context)),
                            MenuItem(
                                context: context,
                                title: "Quit",
                                action: () => exit(0))
                          ])),
                          Container(
                              height: 1.0,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey[400],
                              child: const Text("")),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: zStore.widgetForZone("appBar"),
                              ),
                            ],
                          ),
                          Container(
                              height: 1.0,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey[400],
                              child: const Text("")),
                        ])),
                    Expanded(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                flex: 2,
                                child: SingleChildScrollView(
                                    child: zStore.widgetForZone("sidebar"))),
                            const DesktopVerticalDivider(),
                            Expanded(
                              flex: 8,
                              child: SingleChildScrollView(
                                  child: zStore.widgetForZone("main")),
                            ),
                          ]),
                    ),
                  ],
                ))
            : const Center(child: CircularProgressIndicator()));
  }
}
   ```

#### Update a zone

Provide the name of the zone and a widget:

   ```dart
   zones.update("sidebar", MyWidget());
   ```

## Widgets

### Menu bar

A top menu text bar. The main menu bar of an app

   ```dart
   MenuBar(MenuBarData(menuItems: <MenuItem>[
      MenuItem(
          context: context,
          title: "About",
          action: () => aboutDialog(context)),
      MenuItem(
          context: context,
          title: "Quit",
          action: () => exit(0))
      ]))
   ```

### Section header

A vertical listing section header

   ```dart
   DesktopSectionHeader(title: "Dart packages", borderTop: false)
   ```

### Vertical divider

A line dividing vertical sections

   ```dart
   DesktopVerticalDivider()
   ```