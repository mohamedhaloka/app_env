import 'dart:developer';
import 'dart:io';
import 'package:cli_util/cli_logging.dart';
import 'package:xml/xml.dart';

class AndroidXMLHandler {
  XmlDocument? _document;
  File? _xmlFile;

  String? get content => _document?.document?.outerXml;

  AndroidXMLHandler(String filePath) {
    _xmlFile = File(filePath);
  }

  Future<File?> init({Map<String, String>? data}) async {
    try {
      final bool fileIsExists = _xmlFile!.existsSync();
      if (fileIsExists) {
        final content = _xmlFile!.readAsStringSync();
        if (content.isEmpty) {
          await updateFileContent(xmlFileContent);
        }

        _document = XmlDocument.parse(_xmlFile!.readAsStringSync());

        final XmlElement? resourcesElement = _document?.getElement('resources');
        if (resourcesElement == null) {
          await updateFileContent(xmlFileContent);
        }

        await _modifyStringTag(data ?? {});
        return _xmlFile;
      }
      await _xmlFile!.create(recursive: true);
      await updateFileContent(xmlFileContent);
      await init(data: data);
    } on XmlException {
      Logger logger = Logger.standard();
      logger.stdout("strings.xml wrong formatted");
    }
    return null;
  }

  Future<String?> getTagValue(String namePropValue, [String? newValue]) async {
    try {
      for (var element
          in _document!.getElement('resources')!.findElements('string')) {
        if (element.getAttribute("name") == namePropValue) {
          if (newValue != null) {
            element.innerText = newValue;
          }
          return element.innerText;
        }
      }
    } catch (e) {
      log('ERROR $e');
    }
    return null;
  }

  Future<void> _modifyStringTag(Map<String, String> data) async {
    try {
      final XmlElement? resourcesTag = _document?.getElement('resources');
      final XmlElement? stringTag = resourcesTag!.getElement('string');
      String tags = '';

      data.forEach(
        (key, value) => tags += '\n<string name="$key">$value</string>\n',
      );

      if (stringTag == null) {
        resourcesTag.innerXml = tags;
      } else {
        String content = '';

        Set<String> tagsAdded = {};
        for (var p0 in resourcesTag.children) {
          final String? nameAttr = p0.getAttribute('name');
          if (nameAttr == null) continue;
          if (tagsAdded.contains(nameAttr)) continue;

          if (data.containsKey(nameAttr)) {
            p0.innerText = data[nameAttr]!;
            tagsAdded.add(nameAttr);
          }
        }
        data.forEach((key, value) {
          if (!tagsAdded.contains(key)) {
            content += '\n<string name="$key">$value</string>\n';
          }
        });

        resourcesTag.innerXml += content;
      }

      await updateFileContent(_document!.outerXml);
    } catch (_) {}
  }

  Future<File>? updateFileContent(String text) => _xmlFile?.writeAsString(text);
}

const xmlFileContent = '''<?xml version="1.0" encoding="utf-8"?>
<resources>
</resources>
''';
