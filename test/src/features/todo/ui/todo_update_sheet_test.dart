import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
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
  late DateTime date;
  late Todo todo;
  late Todo newTodo;
  late MockTodoService mockTodoService;

  setUp(() {
    fakes = const Fakes();
    date = DateUtils.dateOnly(fakes.date);
    todo = fakes.todo1().copyWith(due: Value(date));
    newTodo = todo.copyWith(
      title: 'New todo',
      due: Value(date.add(const Duration(days: 1))),
    );
    mockTodoService = MockTodoService();
  });

  Future<void> mockUpdateTodo() {
    return mockTodoService.updateTodo(newTodo.toCompanion(false));
  }

  group('todo update sheet', () {
    testWidgets('should update data', (tester) async {
      when(mockUpdateTodo).thenAnswer(
        (_) => Future<void>.delayed(const Duration(microseconds: 100)),
      );
      await tester.pumpApp(
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: TodoUpdateSheet(todo),
      );
      await tester.enterText(find.byType(TextField), newTodo.title);
      await tester.tap(find.byIcon(Icons.calendar_today_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${date.day + 1}'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.done_outlined));
      verify(mockUpdateTodo).called(1);
      await tester.pump();
      expect(find.byType(CircularProgressDialog), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressDialog), findsNothing);
    });

    testWidgets('should update error', (tester) async {
      when(mockUpdateTodo).thenThrow(Exception());
      await tester.pumpApp(
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: TodoUpdateSheet(todo),
      );
      await tester.enterText(find.byType(TextField), newTodo.title);
      await tester.tap(find.byIcon(Icons.calendar_today_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${date.day + 1}'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.done_outlined));
      verify(mockUpdateTodo).called(1);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressDialog), findsNothing);
    });
  });
}
