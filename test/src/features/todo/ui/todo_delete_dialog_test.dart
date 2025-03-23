import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:samples/src/features/todo/todo.dart';
import 'package:samples/src/shared/core/core.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import '../../../../extensions/fakes.dart';
import '../../../../extensions/pump.dart';
import '../infra/todo_service_test.dart';

void main() {
  late Fakes fakes;
  late Todo todo;
  late MockTodoService mockTodoService;

  setUp(() {
    fakes = const Fakes();
    todo = fakes.todo1();
    mockTodoService = MockTodoService();
  });

  Future<bool> mockDeleteTodo() => mockTodoService.deleteTodo(todo);

  group('todo delete dialog', () {
    testWidgets('should delete cancel', (tester) async {
      await tester.pumpApp(
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: TodoDeleteDialog(todo),
      );
      await tester.tap(find.text('cancel'));
      verifyNever(mockDeleteTodo);
      await tester.pumpAndSettle();
    });

    testWidgets('should delete data', (tester) async {
      when(mockDeleteTodo).thenAnswer((_) {
        return Future<bool>.delayed(
          const Duration(microseconds: 100),
          () => true,
        );
      });
      await tester.pumpApp(
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: TodoDeleteDialog(todo),
      );
      await tester.tap(find.text('delete'));
      verify(mockDeleteTodo).called(1);
      await tester.pump();
      expect(find.byType(CircularProgressDialog), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressDialog), findsNothing);
    });

    testWidgets('should delete error', (tester) async {
      when(mockDeleteTodo).thenThrow(Exception());
      await tester.pumpApp(
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: TodoDeleteDialog(todo),
      );
      await tester.tap(find.text('delete'));
      verify(mockDeleteTodo).called(1);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressDialog), findsNothing);
    });
  });
}
