import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/src/features/fln/state/create.dart';
import 'package:samples/src/shared/theme/theme.dart';

class FLNScheduledCard extends ConsumerWidget {
  const FLNScheduledCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.access_time_outlined),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'scheduled', style: context.titleLarge),
                    TextSpan(text: ' in 5s ', style: context.bodyLargeHint),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: () {
                  final date = DateTime.now().add(const Duration(seconds: 5));
                  ref.read(createFLNProvider.notifier).runScheduled(date);
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
