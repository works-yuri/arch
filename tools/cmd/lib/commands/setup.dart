import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

class Setup extends Command {
  @override
  String get description => 'Setup';

  @override
  String get name => 'setup';

  @override
  List<String> get aliases => ['init', 'start'];

  @override
  ArgParser get argParser {
    return ArgParser()..addOption(
      'key',
      abbr: 'k',
      help: 'Your Flutter Faster API key.',
      valueHelp: 'API KEY',
    );
  }

  @override
  Future<void> run() async {
    String? pat = argResults?['key'] as String?;
    print('setup');
    print(pat);
  }
}
