import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/features/fln/domain/fln.dart';
import 'package:samples/src/features/fln/infra/fln_platform.dart';
part 'fln_service.g.dart';

@riverpod
FLNService flnService(Ref ref) => FLNService(ref.watch(flnPlatformProvider));

class FLNService extends Equatable {
  const FLNService(this.platform);

  final FLNPlatform platform;

  @override
  List<FLNPlatform> get props => [platform];

  Future<void> initialize() => platform.initialize();

  Future<void> create(FLN fln) => platform.show(fln);

  Future<void> createScheduled(FLN fln) => platform.showScheduled(fln);

  Future<void> createUpdatable(FLN fln) async {
    await create(fln);
    for (var i = 1; i <= 10; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      await platform.update(fln.copyWithRunning(i));
    }
    return platform.update(fln.copyWithTired());
  }
}
