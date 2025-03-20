import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:samples/src/features/info/info.dart';
import '../../../../extensions/fakes.dart';
import '../../../../extensions/pump.dart';
import '../infra/info_service_test.dart';

void main() {
  late Fakes fakes;
  late PackageInfo packageInfo;
  late MockInfoService mockInfoService;

  setUp(() {
    fakes = const Fakes();
    packageInfo = fakes.packageInfo();
    mockInfoService = MockInfoService();
  });

  Future<PackageInfo> mockFetchInfo() => mockInfoService.fetchInfo();

  testWidgets('InfoPage should render data', (tester) async {
    when(mockFetchInfo).thenAnswer((_) async => packageInfo);
    await tester.pumpApp(
      scaffold: false,
      overrides: [infoServiceProvider.overrideWithValue(mockInfoService)],
      child: const InfoPage(),
    );
    expect(find.byType(InfoPage), findsOneWidget);
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.byType(SliverAppBar), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(find.byType(SliverList), findsOneWidget);
  });

  testWidgets('InfoPage should render error', (tester) async {
    when(mockFetchInfo).thenAnswer((_) async => throw Error());
    await tester.pumpApp(
      scaffold: false,
      overrides: [infoServiceProvider.overrideWithValue(mockInfoService)],
      child: const InfoPage(),
    );
    expect(find.byType(InfoPage), findsOneWidget);
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.byType(SliverAppBar), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(find.textContaining('Error: '), findsOneWidget);
  });
}
