import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/src/features/fln/state/create.dart';
import 'package:samples/src/shared/theme/theme.dart';

class FLNUpdatableCard extends ConsumerWidget {
  const FLNUpdatableCard({super.key});

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
              leading: const Icon(Icons.update_outlined),
              title: const Text('updatable'),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: () {
                  ref.read(createFLNProvider.notifier).runUpdatable();
                },
                child: const Text('show'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
