import 'dart:io';
import 'dart:convert';

/// Manage configuration files
class ConfigManager {
  /// Provide an app name and a optionaly a file location
  /// If the file location is not provided it will try to
  /// detect the home directory from environnement variables
  /// and create a .appname folder. If no home directory is
  /// found it will use the current directory
  ConfigManager({this.app, this.location}) {
    _file = File(location);
    if (_file.existsSync() == false) throw ("File $location does not exist");
  }

  /// The configuration file location
  String location;

  /// The app name
  final String app;

  Map<String, dynamic> _data = <String, dynamic>{};
  File _file;
  Directory _homeDir;
  Directory _appConfigDir;

  /// The home directory
  Directory get homeDir => _homeDir;

  /// The directory where the configuration lives
  Directory get appConfigDir => _appConfigDir;

  /// Auto configure the config location
  ConfigManager.auto(String appName)
      : this.app = appName,
        this.location = null {
    _setAppConfigDirectory();
    // set config file
    final filePath = "${_appConfigDir.path}/config.json";
    final f = File(filePath);
    if (!f.existsSync()) {
      print("Creating config file ${f.path} for app $app");
      f.createSync();
    }
    _file = f;
  }
/*
  dynamic _key(String value) {
    for (final k in _data.keys) {
      if (k == value) return _data[value];
    }
    return null;
  }*/

  /// Read config file
  Map<String, dynamic> read() {
    assert(_file != null);
    final _fileData = <String, dynamic>{};
    try {
      final content = _file.readAsStringSync();
      if (content == "") {
        return <String, dynamic>{};
      }
      final dynamic _rawFileData = json.decode(content);
      final _fileData = <String, dynamic>{};
      _rawFileData.forEach((String k, dynamic v) {
        _fileData[k.toString()] = v;
      });
      _data = _fileData;
    } catch (e) {
      throw ("Can not process config file $e");
    }
    return _fileData;
  }

  /// Write config file
  void write([Map<String, dynamic> jsonData]) {
    assert(_file != null);
    jsonData ??= _data;
    final content = json.encode(jsonData);
    _file.writeAsStringSync(content);
    _data = jsonData;
  }

  void _setAppConfigDirectory() {
    if (_homeDir == null) _setHomeDir();
    final dir = Directory("${_homeDir.path}/.$app");
    if (!dir.existsSync()) {
      print("Creating configuration directory ${dir.path} for app $app");
      dir.createSync();
    }
    _appConfigDir = dir;
  }

  void _setHomeDir() {
    if (_homeDir != null) return null;
    String path;
    bool found = false;
    final Map<String, String> envs = Platform.environment;
    if (envs.containsKey("HOME")) {
      path = envs["HOME"];
      found = true;
    }
    if (!found) throw ("Home directory not found");
    _homeDir = Directory(path);
  }
}
