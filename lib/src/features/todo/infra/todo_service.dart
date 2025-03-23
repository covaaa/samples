import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/shared/drift/store/store.dart';
part 'todo_service.g.dart';

@riverpod
TodoService todoService(Ref ref) => TodoService(ref.watch(driftStoreProvider));

class TodoService {
  const TodoService(this.store);

  final DriftStore store;

  $TodosTable get _todos => store.todos;

  $DriftStoreManager get _managers => store.managers;

  Future<int> createTodo(Todo todo) => _todos.insertOne(todo);

  Future<void> updateTodo(Todo todo) => _todos.replaceOne(todo);

  Future<bool> deleteTodo(Todo todo) => _todos.deleteOne(todo);

  Stream<List<Todo>> emitsTodos() => _managers.todos.watch();
}
