import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:samples/src/features/todo/state/update.dart';
import 'package:samples/src/shared/core/core.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import 'package:samples/src/shared/theme/theme.dart';

class TodoUpdateSheet extends HookConsumerWidget {
  const TodoUpdateSheet(this.todo, {super.key});

  static Future<void> show(BuildContext context, {required Todo todo}) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: context.surface,
      builder: (context) => TodoUpdateSheet(todo),
    );
  }

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yMMMd = DateFormat.yMMMd();
    final controller = useTextEditingController(text: todo.title);
    final due = useState(todo.due);

    void syncTitle() => controller.text;

    void syncDue(DateTime? newDue) => due.value = newDue ?? due.value;

    Dispose effect() {
      controller.addListener(syncTitle);
      return () => controller.removeListener(syncTitle);
    }

    useEffect(effect, [controller]);

    ref.listen(
      updateTodoProvider,
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
          const SliverAppBar.large(pinned: false, title: Text('Edit Todo')),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ListTile(
                  onTap: () async {
                    final now = DateTime.now();
                    final initialDate = todo.due ?? now;
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
              onPressed: () {
                final updater = ref.read(updateTodoProvider.notifier);
                final newTodo = todo.copyWith(
                  title: controller.text,
                  due: Value(due.value),
                );
                return switch (newTodo == todo) {
                  true => Navigator.pop(context),
                  false => updater.run(newTodo),
                };
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
