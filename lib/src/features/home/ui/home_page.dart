import 'package:flutter/material.dart';
import 'package:samples/src/shared/core/core.dart';
import 'package:samples/src/shared/l10n/l10n.dart';
import 'package:samples/src/shared/locale/locale.dart';
import 'package:samples/src/shared/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(l10n.title),
            actions: [
              IconButton(
                onPressed: () => LocaleSheet.show(context),
                icon: const Icon(Icons.translate_outlined),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: CustomScrolledCenter(
              children: [
                Text(l10n.increment_title),
                Text(
                  '$_counter ${l10n.increment_suffix}',
                  style: context.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: l10n.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
