import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samples/src/features/info/infra/info_service.dart';
part 'read.g.dart';

@riverpod
FutureOr<PackageInfo> readInfo(Ref ref) {
  return ref.watch(
    infoServiceProvider.select((service) => service.fetchInfo()),
  );
}
