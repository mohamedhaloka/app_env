import 'dart:io';

class EnvHandler {
  File? _file;
  String? _filePath;

  Future<String> get fileContent async {
    await _checkFileExistOrCreate();

    return _file!.readAsStringSync();
  }

  EnvHandler(String filePath) {
    _filePath = filePath;
  }

  Future<void> _checkFileExistOrCreate() async {
    _file = File(_filePath!);
    final bool fileIsExists = _file!.existsSync();

    if (fileIsExists) return;

    await _file!.create(recursive: true);
    await _file!.writeAsString(envFileContent);
  }

  Future<String?> getValueFromEnv(String key) async {
    await _checkFileExistOrCreate();
    String fileContent = await _file!.readAsString();
    RegExp regExp = RegExp('$key=.*');
    var matches = regExp.allMatches(fileContent).toList();

    for (var item in matches) {
      return fileContent
          .substring(item.start, item.end)
          .replaceAll("$key=", "");
    }
    return null;
  }

  Future<Map<String, String>> extract() async {
    await _checkFileExistOrCreate();
    Map<String, String> data = {};
    RegExp regExp = RegExp('.*=.*');
    String fileContent = await _file!.readAsString();
    var matches = regExp.allMatches(fileContent).toList();

    for (var item in matches) {
      String content = fileContent.substring(item.start, item.end);
      int indexOfEqualChar = content.indexOf("=");
      String key = content.substring(0, indexOfEqualChar);
      String value = content.substring(indexOfEqualChar + 1);
      data.addAll({key.trim(): value.trim()});
    }
    return data;
  }
}

const envFileContent = '''BASE_URL=https://examole.com''';
