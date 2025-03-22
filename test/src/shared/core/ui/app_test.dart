import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/todo/todo.dart';
import 'package:samples/src/shared/core/core.dart';
import '../../../../extensions/pump.dart';
import '../../../features/todo/infra/todo_service_test.dart';

void main() {
  testWidgets('app should render todo page', (tester) async {
    await tester.pumpApp(
      scaffold: false,
      overrides: [todoServiceProvider.overrideWithValue(MockTodoService())],
      child: const App(),
    );
    expect(find.byType(TodoPage), findsOneWidget);
  });
}
