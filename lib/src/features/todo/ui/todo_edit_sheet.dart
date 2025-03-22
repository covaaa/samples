import 'package:flutter/material.dart';
import 'package:samples/src/shared/core/core.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import 'package:samples/src/shared/theme/theme.dart';

class TodoEditSheet extends StatelessWidget {
  const TodoEditSheet(this.todo, {super.key});

  static Future<void> show(BuildContext context, {required Todo todo}) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: context.surface,
      builder: (context) => TodoEditSheet(todo),
    );
  }

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: IconButton(
              onPressed: null,
              icon: Icon(Icons.edit_outlined, color: context.primary),
            ),
            title: const Text('edit todo'),
          ),
          ListTile(
            leading: IconButton(
              onPressed: null,
              icon: Icon(Icons.delete_outline_outlined, color: context.primary),
            ),
            title: const Text('delete todo'),
          ),
          SizedBox(height: context.viewPaddingBottom),
        ],
      ),
    );
  }
}
