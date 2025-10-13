import 'package:args/command_runner.dart';
import 'commands/clean.dart';
import 'commands/setup.dart';

void run(List<String> arguments) => CommandRunner("tools", "Tools")
  ..addCommand(Setup())
  ..addCommand(Clean())
  ..run(arguments);
