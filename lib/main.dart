import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:samples/src/shared/core/core.dart';

void main() {
  FlutterError.onError = (details) {
    return log(details.exceptionAsString(), stackTrace: details.stack);
  };
  return runZonedGuarded<void>(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      return runApp(const App());
    },
    (error, stackTrace) {
      log('$error', stackTrace: stackTrace);
    },
  );
}
