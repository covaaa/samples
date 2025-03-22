import 'package:flutter_test/flutter_test.dart';
import 'package:samples/src/features/home/home.dart';
import 'package:samples/src/shared/core/core.dart';
import '../../../../extensions/pump.dart';

void main() {
  testWidgets('app should render home page', (tester) async {
    await tester.pumpMaterialApp(scaffold: false, child: const App());
    expect(find.byType(HomePage), findsOneWidget);
  });
}
