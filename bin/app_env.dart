import 'dart:async';
import 'package:app_env/app_env.dart';
import 'package:args/args.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption(
      'environment',
      abbr: 'e',
    );

  final results = parser.parse(args);

  final String environmentFileName = results["environment"] ?? '.env';

  await AppEnv.process(environmentFileName);
}
