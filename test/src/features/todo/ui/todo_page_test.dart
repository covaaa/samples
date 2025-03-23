import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:samples/src/features/todo/todo.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import '../../../../extensions/fakes.dart';
import '../../../../extensions/pump.dart';
import '../../todo/infra/todo_service_test.dart';

void main() {
  late Fakes fakes;
  late List<Todo> todos;
  late MockTodoService mockTodoService;

  setUp(() {
    fakes = const Fakes();
    todos = fakes.todos();
    mockTodoService = MockTodoService();
  });

  Stream<List<Todo>> mockEmitsTodos() => mockTodoService.emitsTodos();

  group('todo page', () {
    testWidgets('should render data', (tester) async {
      when(mockEmitsTodos).thenAnswer((i) => Stream.value(todos));
      await tester.pumpApp(
        scaffold: false,
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: const TodoPage(),
      );
      verify(mockEmitsTodos).called(1);
      expect(find.byType(TodoPage), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
      expect(find.byType(SliverList), findsOneWidget);
      expect(find.byType(TodoCard), findsNWidgets(3));
    });

    testWidgets('should render error', (tester) async {
      when(mockEmitsTodos).thenAnswer((_) => Stream.error(Exception()));
      await tester.pumpApp(
        scaffold: false,
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: const TodoPage(),
      );
      verify(mockEmitsTodos).called(1);
      expect(find.byType(TodoPage), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
      expect(find.textContaining('Error: '), findsOneWidget);
    });

    testWidgets('should show todo create sheet', (tester) async {
      when(mockEmitsTodos).thenAnswer((i) => Stream.value(todos));
      await tester.pumpApp(
        scaffold: false,
        overrides: [todoServiceProvider.overrideWithValue(mockTodoService)],
        child: const TodoPage(),
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(TodoCreateSheet), findsOneWidget);
    });
  });
}
