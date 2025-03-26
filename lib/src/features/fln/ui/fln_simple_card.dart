import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/src/features/fln/state/create.dart';
import 'package:samples/src/shared/theme/theme.dart';

class FLNSimpleCard extends ConsumerWidget {
  const FLNSimpleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              titleTextStyle: context.titleLarge,
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('simple'),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: () => ref.read(createFLNProvider.notifier).run(),
                child: const Text('show'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
