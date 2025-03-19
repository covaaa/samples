import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/shared/core/core.dart';

void main() {
  testWidgets('App should render HomePage', (tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(App), findsOneWidget);
  });
}
