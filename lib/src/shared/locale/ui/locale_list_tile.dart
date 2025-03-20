import 'package:flutter/material.dart';
import 'package:samples/src/shared/l10n/l10n.dart';
import 'package:samples/src/shared/locale/ui/locale_sheet.dart';

class LocaleListTile extends StatelessWidget {
  const LocaleListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      onTap: () => LocaleSheet.show(context),
      leading: const Icon(Icons.translate_outlined),
      title: Text(l10n.language),
      subtitle: Text(l10n.locale),
    );
  }
}
