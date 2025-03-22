import 'package:flutter/material.dart';
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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('Samples')),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // * _LargeScrollUnderFlexibleConfig at material/app_bar.dart
                // * expandedHeight = 152.0;
                // * expandedTitlePadding.bottom = 28.0;
                const SizedBox(height: 152 + 28),
                const Text('You have pushed the button this many times:'),
                Text('$_counter', style: context.headlineMedium),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
