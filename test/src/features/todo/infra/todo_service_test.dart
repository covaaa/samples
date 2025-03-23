import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:samples/src/features/todo/todo.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import '../../../../extensions/fakes.dart';

class MockTodoService extends Mock implements TodoService {}

void main() {
  late Fakes fakes;
  late Todo todo;
  late List<Todo> todos;
  late QueryExecutor connection;
  late ProviderContainer container;
  late TodoService service;

  setUp(() {
    fakes = const Fakes();
    todo = fakes.todo4();
    todos = fakes.todos();
    connection = fakes.connection();
    container = ProviderContainer(
      overrides: [driftDatabaseProvider.overrideWithValue(connection)],
    );
    service = container.read(todoServiceProvider);
  });

  tearDown(() {
    container.dispose();
    connection.close();
  });

  group('todo service', () {
    test('should create todo', () {
      expect(service.createTodo(todo), completion(4));
    });

    test('should update todo', () async {
      await service.createTodo(todo);
      expect(
        service.updateTodo(todo.copyWith(title: 'updated todo')),
        completion(isA<void>()),
      );
    });

    test('should delete todo', () async {
      await service.createTodo(todo);
      expect(service.deleteTodo(todo), completion(isTrue));
    });

    test('should emits todos', () {
      expect(
        service.emitsTodos(),
        emits(
          isA<List<Todo>>()
              .having(
                (todos) => todos.map((todo) => todo.id),
                'should be expected ids',
                todos.map((todo) => todo.id),
              )
              .having(
                (todos) => todos.map((todo) => todo.title),
                'should be expected titles',
                todos.map((todo) => todo.title),
              ),
        ),
      );
    });
  });
}
