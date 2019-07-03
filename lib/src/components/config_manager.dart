import 'dart:io';
import 'dart:convert';

class ConfigManager {
  ConfigManager({this.app, this.location}) {
    _file = File(location);
    if (_file.existsSync() == false) throw ("File $location does not exist");
  }

  String location;
  final String app;

  Map<String, dynamic> data = <String, dynamic>{};
  File _file;
  Directory _homeDir;
  Directory _appConfigDir;

  Directory get homeDir => _homeDir;
  Directory get appConfigDir => _appConfigDir;

  ConfigManager.auto(String appName)
      : this.app = appName,
        this.location = null {
    _setAppConfigDirectory();
    // set config file
    String filePath = "${_appConfigDir.path}/config.json";
    File f = File(filePath);
    if (!f.existsSync()) {
      print("Creating config file ${f.path} for app $app");
      f.createSync();
    }
    _file = f;
  }

  dynamic key(String value) {
    for (final k in data.keys) {
      if (k == value) return data[value];
    }
    return null;
  }

  Map<String, dynamic> read() {
    assert(_file != null);
    var _fileData = <String, dynamic>{};
    try {
      String content = _file.readAsStringSync();
      if (content == "") return {};
      dynamic _rawFileData = json.decode(content);
      Map<String, dynamic> _fileData = {};
      _rawFileData.forEach((k, v) {
        _fileData[k.toString()] = v;
      });
      data = _fileData;
    } catch (e) {
      throw ("Can not process config file $e");
    }
    return _fileData;
  }

  void write([dynamic jsonData]) {
    assert(_file != null);
    if (jsonData == null) jsonData = data;
    String content = json.encode(jsonData);
    _file.writeAsStringSync(content);
    data = jsonData;
  }

  void _setAppConfigDirectory() {
    if (_homeDir == null) _setHomeDir();
    Directory dir = Directory("${_homeDir.path}/.$app");
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
    Map<String, String> envs = Platform.environment;
    if (envs.containsKey("HOME")) {
      path = envs["HOME"];
      found = true;
    }
    if (!found) throw ("Home directory not found");
    _homeDir = Directory(path);
  }
}
