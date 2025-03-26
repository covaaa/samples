import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/fln/fln.dart';
import 'package:samples/src/shared/core/core.dart';
import '../../../../extensions/pump.dart';

void main() {
  testWidgets('app should render fln page', (tester) async {
    await tester.pumpApp(scaffold: false, child: const App());
    expect(find.byType(FLNPage), findsOneWidget);
  });
}
