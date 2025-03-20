import 'package:package_info_plus/package_info_plus.dart';

class Fakes {
  const Fakes();
  PackageInfo packageInfo() {
    return PackageInfo(
      appName: 'fake app',
      packageName: 'com.fake',
      version: 'x.x.x',
      buildNumber: 'x',
      buildSignature: 'xxxx',
      installerStore: 'com.store.fake',
    );
  }
}
