import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:samples/src/features/info/state/read.dart';

class InfoPage extends ConsumerWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('flavors')),
          switch (ref.watch(readInfoProvider)) {
            AsyncValue<PackageInfo>(:final valueOrNull?) => SliverList(
              delegate: SliverChildListDelegate.fixed([
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: const Text('App name'),
                  subtitle: Text(valueOrNull.appName),
                ),
                ListTile(
                  leading: const Icon(Icons.domain_outlined),
                  title: const Text('Package name'),
                  subtitle: Text(valueOrNull.packageName),
                ),
                ListTile(
                  leading: const Icon(Icons.commit_outlined),
                  title: const Text('App version'),
                  subtitle: Text(valueOrNull.version),
                ),
                ListTile(
                  leading: const Icon(Icons.construction_outlined),
                  title: const Text('Build number'),
                  subtitle: Text(valueOrNull.buildNumber),
                ),
                ListTile(
                  leading: const Icon(Icons.fingerprint_outlined),
                  title: const Text('Build signature'),
                  subtitle: Text(valueOrNull.buildSignature),
                ),
                ListTile(
                  leading: const Icon(Icons.store_outlined),
                  title: const Text('Installer store'),
                  subtitle: Text(valueOrNull.installerStore ?? 'not available'),
                ),
              ]),
            ),
            AsyncValue(:final error?) => SliverToBoxAdapter(
              child: Text('Error: $error'),
            ),
            AsyncValue<PackageInfo>() => const SliverToBoxAdapter(
              child: CircularProgressIndicator.adaptive(),
            ),
          },
        ],
      ),
    );
  }
}
