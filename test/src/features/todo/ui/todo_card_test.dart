import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/todo/todo.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import '../../../../extensions/fakes.dart';
import '../../../../extensions/pump.dart';

void main() {
  late Fakes fakes;
  late Todo todo1;
  late Todo todo4;

  setUp(() {
    fakes = const Fakes();
    todo1 = fakes.todo1();
    todo4 = fakes.todo4();
  });

  group('todo card', () {
    testWidgets('todo card should render title and no due date', (
      tester,
    ) async {
      await tester.pumpApp(child: TodoCard(todo1));
      expect(find.text(todo1.title), findsOneWidget);
      expect(find.text('no due date'), findsOneWidget);
    });

    testWidgets('todo card should render title and due date', (tester) async {
      await tester.pumpApp(child: TodoCard(todo4));
      expect(find.text(todo4.title), findsOneWidget);
      expect(find.text('Dec 31, 2030'), findsOneWidget);
    });
  });
}
