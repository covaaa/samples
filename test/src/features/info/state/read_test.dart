import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:samples/src/features/info/info.dart';
import '../../../../extensions/fakes.dart';
import '../infra/info_service_test.dart';

void main() {
  late Fakes fakes;
  late PackageInfo packageInfo;
  late MockInfoService mockInfoService;
  late ProviderContainer container;

  setUp(() {
    fakes = const Fakes();
    packageInfo = fakes.packageInfo();
    mockInfoService = MockInfoService();
    container = ProviderContainer(
      overrides: [infoServiceProvider.overrideWithValue(mockInfoService)],
    );
  });

  Future<PackageInfo> mockFetchInfo() => mockInfoService.fetchInfo();

  test('should fetch info', () {
    when(mockFetchInfo).thenAnswer((_) async => packageInfo);
    expect(container.read(readInfoProvider.future), completion(packageInfo));
  });
}
