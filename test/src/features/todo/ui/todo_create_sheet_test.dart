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
  late TodosCompanion newTodo;
  late MockTodoService mockTodoService;

  setUp(() {
    fakes = const Fakes();
    date = DateUtils.dateOnly(fakes.date);
    newTodo = fakes.todoCompanion4().copyWith(
      due: Value(date.add(const Duration(days: 1))),
    );
    mockTodoService = MockTodoService();
    registerFallbackValue(newTodo);
  });

  Future<int> mockCreateTodo() => mockTodoService.createTodo(
    any(
      that: isA<TodosCompanion>()
          .having(
            (todo) => todo.title.value,
            'should create title',
            newTodo.title.value,
          )
          .having(
            (todo) => todo.due.value,
            'should create due',
            newTodo.due.value,
          ),
    ),
  );

  group('todo create sheet', () {
    testWidgets('should create data', (tester) async {
      when(mockCreateTodo).thenAnswer(
        (_) => Future<int>.delayed(const Duration(microseconds: 100), () => 4),
      );
      await tester.pumpApp(
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: const TodoCreateSheet(),
      );
      await tester.enterText(find.byType(TextField), newTodo.title.value);
      await tester.tap(find.byIcon(Icons.calendar_today_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${date.day + 1}'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.done_outlined));
      verify(mockCreateTodo).called(1);
      await tester.pump();
      expect(find.byType(CircularProgressDialog), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressDialog), findsNothing);
    });

    testWidgets('should update error', (tester) async {
      when(mockCreateTodo).thenThrow(Exception());
      await tester.pumpApp(
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: const TodoCreateSheet(),
      );
      await tester.enterText(find.byType(TextField), newTodo.title.value);
      await tester.tap(find.byIcon(Icons.calendar_today_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${date.day + 1}'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.done_outlined));
      verify(mockCreateTodo).called(1);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressDialog), findsNothing);
    });
  });
}
