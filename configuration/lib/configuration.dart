import 'dart:async';
import 'dart:ui';

import 'package:configuration/dependencies/dependencies.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:configuration/navigation/navigation.dart';

import 'package:flutter/services.dart';

import 'package:logging/logging.dart';
import 'dart:developer' as developer;

// if (kReleaseMode) {
//       Logger.root.level =
//           Level.WARNING; // Don't log anything below warnings in production.
//     }

// do not show the red error widget when release mode
// if (kReleaseMode) {
//   ErrorWidget.builder = (FlutterErrorDetails details) => Container();
// }

class Configuration {
  final log = Logger('Configuration');
  final navigation = Navigation();
  final dependencies = Dependencies();

  Configuration.setup() {
    Logger.root.onRecord.listen((record) {
      developer.log(
        record.message,
        time: record.time,
        level: record.level.value,
        name: record.loggerName,
        zone: record.zone,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    });

    FlutterError.onError = (FlutterErrorDetails details) {
      log.severe(details.exceptionAsString(), details, details.stack);
    };

    PlatformDispatcher.instance.onError = (error, StackTrace stack) {
      log.severe(null, error, stack);
      return true;
    };

    runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        await dependencies.reset();
        await dependencies.wait();

        runApp(
          Builder(
            builder: (BuildContext context) {
              return MaterialApp.router(
                routerConfig: navigation.config(),
                title: 'Bootstrap',
              );
            },
          ),
        );
      },
      (Object error, StackTrace stack) {
        log.severe(error.toString(), error, stack);
      },
    );
  }
}
