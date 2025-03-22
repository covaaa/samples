import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart' as drift_flutter;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'database.g.dart';

@riverpod
QueryExecutor driftDatabase(Ref ref) => drift_flutter.driftDatabase(
  name: 'drift',
  native: const drift_flutter.DriftNativeOptions(
    databaseDirectory: getApplicationSupportDirectory,
  ),
);
