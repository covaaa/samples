import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import 'platform.dart';

final class Fakes {
  const Fakes();

  DateTime get date => DateTime.now();

  FakePathProviderPlatform platform() => FakePathProviderPlatform();

  DatabaseConnection connection() => DatabaseConnection(
    NativeDatabase.memory(),
    closeStreamsSynchronously: true,
  );

  List<Todo> todos() => [todo1(), todo2(), todo3()];

  Todo todo1() {
    return Todo(
      id: 1,
      title: 'check out drift',
      createdAt: date,
      updatedAt: date,
    );
  }

  Todo todo2() {
    return Todo(
      id: 2,
      title: 'fix session invalidation bug',
      createdAt: date,
      updatedAt: date,
    );
  }

  Todo todo3() {
    return Todo(
      id: 3,
      title: 'add favorite movies to home page',
      createdAt: date,
      updatedAt: date,
    );
  }

  TodosCompanion todoCompanion4() {
    return TodosCompanion(
      id: const Value(4),
      title: const Value('new todo'),
      createdAt: Value(date),
      updatedAt: Value(date),
    );
  }
}
