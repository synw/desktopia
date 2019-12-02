import 'dart:convert';
import 'dart:io';

/// Manage configuration files
class ConfigManager {
  /// Provide an app name and a optionaly a file location
  /// If the file location is not provided it will try to
  /// detect the home directory from environnement variables
  /// and create a .appname folder. If no home directory is
  /// found it will use the current directory
  ConfigManager({this.app, this.location, this.verbose = false}) {
    _file = File(location);
    if (_file.existsSync() == false) {
      throw FileSystemException("File $location does not exist");
    }
  }

  /// The configuration file location
  String location;

  /// The app name
  final String app;

  /// The verbosity level
  final bool verbose;

  /// The config data
  Map<String, dynamic> data = <String, dynamic>{};
  File _file;
  Directory _homeDir;
  Directory _appConfigDir;

  /// The home directory
  Directory get homeDir => _homeDir;

  /// The directory where the configuration lives
  Directory get appConfigDir => _appConfigDir;

  /// Auto configure the config location
  ConfigManager.auto(this.app, {this.verbose = false}) : this.location = null {
    if (verbose) {
      print("Running autoconfig");
    }
    _setAppConfigDirectory();
    // set config file
    final filePath = "${_appConfigDir.path}/config.json";
    final f = File(filePath);
    if (!f.existsSync()) {
      if (verbose) {
        print("Creating config file ${f.path} for app $app");
      }
      f.createSync();
    }
    print("Autoconfiguration completed with file ${f.path}");
    _file = f;
  }

  /// get a config value
  dynamic key(String value) {
    for (final k in data.keys) {
      if (k == value) return data[value];
    }
    return null;
  }

  /// Read config file
  Map<String, dynamic> read() {
    assert(_file != null);
    if (verbose) {
      print("Reading config file ${_file.path}");
    }
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
      data = _fileData;
    } catch (e) {
      throw FileSystemException("Can not process config file $e");
    }
    if (verbose) {
      print("Config file data:");
      print("$_fileData");
    }
    return _fileData;
  }

  /// Write config file
  void write([Map<String, dynamic> jsonData]) {
    assert(_file != null);
    jsonData ??= data;
    if (verbose) {
      print("Writing data to config file:");
      print("$data");
    }
    final content = json.encode(jsonData);
    _file.writeAsStringSync(content);
    data = jsonData;
  }

  void _setAppConfigDirectory() {
    if (verbose) {
      print("Setting up app config");
    }
    if (_homeDir == null) {
      if (verbose) {
        print("Home directory not found");
      }
      _setHomeDir();
    }
    final dir = Directory("${_homeDir.path}/.$app");
    if (!dir.existsSync()) {
      if (verbose) {
        print("Creating configuration directory ${dir.path} for app $app");
      }
      dir.createSync();
    }
    if (verbose) {
      print("Setting up config dir: $dir");
    }
    _appConfigDir = dir;
  }

  void _setHomeDir() {
    if (verbose) {
      print("Setting up home directory");
    }
    if (_homeDir != null) {
      if (verbose) {
        print("Home directory already exists: $homeDir");
      }
      return;
    }
    String path;
    var found = false;
    final envs = Platform.environment;
    if (envs.containsKey("HOME")) {
      path = envs["HOME"];
      found = true;
    }
    if (!found) {
      throw const FileSystemException("Home directory not found");
    } else {
      if (verbose) {
        print("Found home directory at $path");
      }
    }
    _homeDir = Directory(path);
  }
}
