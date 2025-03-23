import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/todo/todo.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import '../../../../extensions/fakes.dart';
import '../../../../extensions/pump.dart';

void main() {
  late Fakes fakes;
  late Todo todo1;

  setUp(() {
    fakes = const Fakes();
    todo1 = fakes.todo1();
  });

  group('todo edit sheet', () {
    testWidgets('should show todo update sheet', (tester) async {
      await tester.pumpApp(child: TodoEditSheet(todo1));
      await tester.tap(find.byType(ListTile).at(0));
      await tester.pumpAndSettle();
      expect(find.byType(TodoUpdateSheet), findsOneWidget);
    });
  });
}
