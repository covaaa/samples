import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/features/todo/infra/todo_service.dart';
import 'package:samples/src/shared/core/core.dart';
import 'package:samples/src/shared/drift/store/store.dart';
part 'update.g.dart';

@riverpod
class UpdateTodo extends _$UpdateTodo with Load {
  late TodoService _service;

  @override
  Action build() {
    _service = ref.watch(todoServiceProvider);
    return const Action.none();
  }

  Future<void> run(Todo todo) => super.load(() => _service.updateTodo(todo));
}
