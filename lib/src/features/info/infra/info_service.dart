import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'info_service.g.dart';

@riverpod
InfoService infoService(Ref ref) => InfoService();

class InfoService {
  Future<PackageInfo> fetchInfo() => PackageInfo.fromPlatform();
}
