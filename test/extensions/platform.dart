import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

final class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return 'temporaryPath';
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return 'applicationSupportPath';
  }

  @override
  Future<String?> getLibraryPath() async {
    return 'libraryPath';
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return 'applicationDocumentsPath';
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return 'externalStoragePath';
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return ['externalCachePath'];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>['externalStoragePath'];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return 'downloadsPath';
  }
}
