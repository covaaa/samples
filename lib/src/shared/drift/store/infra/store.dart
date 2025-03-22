import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/shared/drift/runtime/runtime.dart' as runtime;
import 'package:samples/src/shared/drift/store/infra/database.dart';
import 'package:samples/src/shared/drift/store/infra/table.dart';
part 'store.g.dart';

@riverpod
DriftStore driftStore(Ref ref) {
  final store = DriftStore(ref.watch(driftDatabaseProvider));
  ref.onDispose(store.close);
  return store;
}

@DriftDatabase(tables: [Todos])
class DriftStore extends _$DriftStore {
  DriftStore(super.e);
  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      if (details.wasCreated) {
        await batch((instance) {
          final date = DateTime.now();
          instance.insertAll(todos, [
            TodosCompanion.insert(
              title: 'check out drift',
              createdAt: date,
              updatedAt: date,
            ),
            TodosCompanion.insert(
              title: 'fix session invalidation bug',
              createdAt: date,
              updatedAt: date,
            ),
            TodosCompanion.insert(
              title: 'add favorite movies to home page',
              createdAt: date,
              updatedAt: date,
            ),
          ]);
        });
      }
      await runtime.validateDatabaseSchema(this);
    },
  );
}
