import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samples/src/shared/l10n/l10n.dart';
import 'package:samples/src/shared/locale/domain/locale.dart';
import 'package:samples/src/shared/locale/state/read.dart';
import 'package:samples/src/shared/theme/theme.dart';

class LocaleSheet extends ConsumerStatefulWidget {
  const LocaleSheet(this.locale, {super.key});

  final Locale locale;

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: context.surface,
      builder: (context) => LocaleSheet(Localizations.localeOf(context)),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocaleSheetState();
}

class _LocaleSheetState extends ConsumerState<LocaleSheet> {
  late SealedLocale locale;

  @override
  void initState() {
    super.initState();
    locale = SealedLocale(widget.locale);
  }

  @override
  Widget build(BuildContext context) {
    void onChanged(SealedLocale? newLocale) {
      return setState(() => locale = newLocale!);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: false,
            title: Text(lookupL10n(locale).language),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              RadioListTile<SealedLocale>(
                onChanged: onChanged,
                groupValue: locale,
                value: const LocaleEn(),
                title: Text(lookupL10n(const LocaleEn()).locale),
              ),
              RadioListTile<SealedLocale>(
                onChanged: onChanged,
                groupValue: locale,
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
                final _ = switch (locale) {
                  LocaleEn() => ref.read(readLocaleProvider.notifier).syncEn(),
                  LocaleJa() => ref.read(readLocaleProvider.notifier).syncJa(),
                };
                await Navigator.maybePop(context);
              },
              child: Text(lookupL10n(locale).done),
            ),
          ),
        ),
      ),
    );
  }
}
