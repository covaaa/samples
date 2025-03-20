import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samples/src/shared/l10n/l10n.dart';
import 'package:samples/src/shared/locale/domain/locale.dart';
import 'package:samples/src/shared/locale/state/read.dart';
import 'package:samples/src/shared/locale/ui/x_locale.dart';
import 'package:samples/src/shared/theme/theme.dart';

class LocaleSheet extends HookConsumerWidget {
  const LocaleSheet(this.locale, {super.key});

  final SealedLocale locale;

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: context.surface,
      builder: (context) => LocaleSheet(context.locale),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = useState(locale);

    void onChanged(SealedLocale? newLocale) {
      group.value = newLocale ?? group.value;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: false,
            title: Text(lookupL10n(group.value).language),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              RadioListTile<SealedLocale>(
                onChanged: onChanged,
                groupValue: group.value,
                value: const LocaleEn(),
                title: Text(lookupL10n(const LocaleEn()).locale),
              ),
              RadioListTile<SealedLocale>(
                onChanged: onChanged,
                groupValue: group.value,
                value: const LocaleJa(),
                title: Text(lookupL10n(const LocaleJa()).locale),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: context.surface,
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                final _ = switch (group.value) {
                  LocaleEn() => ref.read(readLocaleProvider.notifier).syncEn(),
                  LocaleJa() => ref.read(readLocaleProvider.notifier).syncJa(),
                };
                await Navigator.maybePop(context);
              },
              child: Text(lookupL10n(group.value).done),
            ),
          ),
        ),
      ),
    );
  }
}
