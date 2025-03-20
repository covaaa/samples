import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/shared/core/core.dart';
import '../../../../extensions/pump.dart';

void main() {
  testWidgets('App should render HomePage', (tester) async {
    await tester.pumpApp(scaffold: false, child: const App());
    expect(find.byType(App), findsOneWidget);
  });
}
