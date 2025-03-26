import 'package:flutter/material.dart';
import 'package:samples/src/features/fln/ui/fln_scheduled_card.dart';
import 'package:samples/src/features/fln/ui/fln_simple_card.dart';
import 'package:samples/src/features/fln/ui/fln_updatable_card.dart';

class FLNPage extends StatelessWidget {
  const FLNPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(title: Text('Notifications')),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                FLNSimpleCard(),
                FLNUpdatableCard(),
                FLNScheduledCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
