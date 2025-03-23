import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:samples/src/features/todo/state/create.dart';
import 'package:samples/src/shared/core/core.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import 'package:samples/src/shared/theme/theme.dart';

class TodoCreateSheet extends HookConsumerWidget {
  const TodoCreateSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: context.surface,
      builder: (context) => const TodoCreateSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yMMMd = DateFormat.yMMMd();
    final controller = useTextEditingController();
    final due = useState<DateTime?>(null);

    void syncTitle() => controller.text;

    void syncDue(DateTime? newDue) => due.value = newDue ?? due.value;

    Dispose effect() {
      controller.addListener(syncTitle);
      return () => controller.removeListener(syncTitle);
    }

    useEffect(effect, [controller]);

    ref.listen(
      createTodoProvider,
      (previous, next) => switch (next) {
        ActionNone() => null,
        ActionLoading() => CircularProgressDialog.show(context),
        ActionSome() => Navigator.popUntil(context, (route) => route.isFirst),
        ActionError() => Navigator.pop(context),
      },
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(pinned: false, title: Text('New Todo')),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ListTile(
                  onTap: () async {
                    final now = DateTime.now();
                    final initialDate = DateTime.now();
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: initialDate.isBefore(now) ? initialDate : now,
                      lastDate: DateTime(3000),
                    );
                    syncDue(selectedDate);
                  },
                  iconColor: context.primary,
                  textColor: context.primary,
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: switch (due.value) {
                    final DateTime date => Text(yMMMd.format(date)),
                    null => const Text('no due date'),
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: controller,
                    style: context.headlineSmall,
                    decoration: const InputDecoration(
                      hintText: 'what needs to be done?',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: context.surface,
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () async {
                final now = DateTime.now();
                final newTodo = TodosCompanion(
                  title: Value(controller.text),
                  due: Value(due.value),
                  createdAt: Value(now),
                  updatedAt: Value(now),
                );
                return ref.read(createTodoProvider.notifier).run(newTodo);
              },
              icon: const Icon(Icons.done_outlined),
              label: const Text('done'),
            ),
          ),
        ),
      ),
    );
  }
}
