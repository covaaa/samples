import 'package:flutter/material.dart';
import 'package:samples/src/shared/core/core.dart';
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
            child: CustomScrolledCenter(
              children: [
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
