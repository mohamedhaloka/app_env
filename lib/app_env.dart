import 'dart:async';

import 'package:app_env/helpers/android_xml_helper.dart';
import 'package:app_env/helpers/env_helper.dart';
import 'package:app_env/helpers/ios_config_helper.dart';

class AppEnv {
  static String get _stringXml => 'android/app/src/main/res/values/strings.xml';
  static String get _iOSConfig => 'ios/Flutter/AppEnvConfig.xcconfig';

  static Future<void> process(String envFileName) async {
    final EnvHandler env = EnvHandler(envFileName);
    final String envFilePath = await env.fileContent;

    final Map<String, String> data = await env.extract();

    await AndroidXMLHandler(_stringXml).init(data: data);

    await IOSConfigHandler(_iOSConfig).modify(envFilePath);
  }
}
