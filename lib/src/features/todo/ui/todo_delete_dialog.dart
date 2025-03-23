import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samples/src/features/todo/state/delete.dart';
import 'package:samples/src/shared/core/core.dart';
import 'package:samples/src/shared/drift/store/store.dart';

class TodoDeleteDialog extends ConsumerWidget {
  const TodoDeleteDialog(this.todo, {super.key});

  final Todo todo;

  static Future<void> show(BuildContext context, {required Todo todo}) {
    return showDialog(
      context: context,
      builder: (context) => TodoDeleteDialog(todo),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      deleteTodoProvider,
      (previous, next) => switch (next) {
        ActionNone() => null,
        ActionLoading() => CircularProgressDialog.show(context),
        ActionSome() => Navigator.popUntil(context, (route) => route.isFirst),
        ActionError() => Navigator.pop(context),
      },
    );

    return AlertDialog(
      title: const Text('Delete this todo?'),
      content: Text(
        '"${todo.title}" will be permanently removed from your devices',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.maybePop(context),
          child: const Text('cancel'),
        ),
        TextButton(
          onPressed: () {
            ref.read(deleteTodoProvider.notifier).run(todo.toCompanion(false));
          },
          child: const Text('delete'),
        ),
      ],
    );
  }
}
