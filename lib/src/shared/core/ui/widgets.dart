import 'package:flutter/material.dart';

class CustomScrolledCenter extends StatelessWidget {
  const CustomScrolledCenter({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // * _LargeScrollUnderFlexibleConfig at material/app_bar.dart
      // * expandedHeight = 152.0;
      // * expandedTitlePadding.bottom = 28.0;
      const SizedBox(height: 152 + 28),
      ...children,
    ],
  );
}

class CircularProgressDialog extends StatelessWidget {
  const CircularProgressDialog({super.key});

  static Future<void> show(BuildContext context) => showAdaptiveDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (context) => const CircularProgressDialog(),
  );

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
