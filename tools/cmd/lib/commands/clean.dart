import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

String get flutterCMD => 'flutter${Platform.isWindows ? '.bat' : ''}';

class Clean extends Command {
  @override
  String get description => 'Perform a deep clean on your Flutter project.';

  @override
  String get name => 'clean';

  @override
  Future<void> run() async {
    // await Process.run(flutterPath, ['clean']);
    print('test 2');
  }
}
