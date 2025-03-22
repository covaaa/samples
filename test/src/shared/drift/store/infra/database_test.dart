import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import '../../../../../extensions/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Fakes fakes;
  late ProviderContainer container;

  setUp(() {
    fakes = const Fakes();
    PathProviderPlatform.instance = fakes.platform();
    container = ProviderContainer();
  });

  tearDown(() => container.dispose());

  test(
    'database should provide instance',
    () => expect(container.read(driftDatabaseProvider), isA<QueryExecutor>()),
  );
}
