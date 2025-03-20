import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samples/src/features/tabs/home/home.dart';
import 'package:samples/src/shared/l10n/l10n.dart';
import 'package:samples/src/shared/locale/locale.dart';
import 'package:samples/src/shared/theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: ref.watch(readLocaleProvider),
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      onGenerateTitle: (context) => context.l10n.title,
      theme: SamplesThemeData.light(ColorSeed.deepPurple.color),
      darkTheme: SamplesThemeData.dark(ColorSeed.deepPurple.color),
      home: const HomePage(),
    );
  }
}
