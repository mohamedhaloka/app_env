import 'dart:io';

class IOSConfigHandler {
  File? _file;
  String? _filePath;

  IOSConfigHandler(String filePath) {
    _filePath = filePath;
  }

  Future<void> _checkFileExistOrCreate() async {
    _file = File(_filePath!);
    final bool fileIsExists = _file!.existsSync();

    if (fileIsExists) return;
  }

  Future<void> modify(String content) async {
    await _checkFileExistOrCreate();
    String fileContent = await _file!.readAsString();

    fileContent = '$iOSConfigFileContent\n$content';

    _file!.writeAsString(fileContent);
  }
}

const iOSConfigFileContent = '''
#include "Generated.xcconfig"
''';
