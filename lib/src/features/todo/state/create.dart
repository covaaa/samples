import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/features/todo/infra/todo_service.dart';
import 'package:samples/src/shared/core/core.dart';
import 'package:samples/src/shared/drift/store/store.dart';
part 'create.g.dart';

@riverpod
class CreateTodo extends _$CreateTodo with Load {
  late TodoService _service;

  @override
  Action build() {
    _service = ref.watch(todoServiceProvider);
    return const Action.none();
  }

  Future<void> run(TodosCompanion todo) {
    return super.load(() => _service.createTodo(todo));
  }
}
