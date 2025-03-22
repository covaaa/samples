import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/features/todo/infra/todo_service.dart';
import 'package:samples/src/shared/drift/store/store.dart';
part 'read.g.dart';

@riverpod
Stream<List<Todo>> readTodos(Ref ref) {
  return ref.watch(
    todoServiceProvider.select((service) => service.emitsTodos()),
  );
}
