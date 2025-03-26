import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/src/features/fln/fln.dart';
import 'package:samples/src/shared/core/core.dart';

void main() {
  FlutterError.onError = (details) {
    return log(details.exceptionAsString(), stackTrace: details.stack);
  };
  return runZonedGuarded<void>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final container = ProviderContainer();
      await container.read(flnServiceProvider).initialize();
      return runApp(
        const ProviderScope(observers: [RiverpodObserver()], child: App()),
      );
    },
    (error, stackTrace) {
      log('$error', stackTrace: stackTrace);
    },
  );
}
