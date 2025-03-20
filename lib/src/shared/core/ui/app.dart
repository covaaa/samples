import 'package:flutter/material.dart';
import 'package:samples/src/features/tabs/home/home.dart';
import 'package:samples/src/shared/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'samples',
      debugShowCheckedModeBanner: false,
      theme: SamplesThemeData.light(ColorSeed.deepPurple.color),
      darkTheme: SamplesThemeData.dark(ColorSeed.deepPurple.color),
      home: const HomePage(),
    );
  }
}
