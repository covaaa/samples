import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/info/info.dart';
import 'package:samples/src/shared/core/core.dart';
import '../../../../extensions/pump.dart';

void main() {
  testWidgets('app should render info page', (tester) async {
    await tester.pumpApp(scaffold: false, child: const App());
    expect(find.byType(InfoPage), findsOneWidget);
  });
}
