import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samples/src/features/todo/ui/todo_edit_sheet.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import 'package:samples/src/shared/theme/theme.dart';

class TodoCard extends StatelessWidget {
  const TodoCard(this.todo, {super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final due = switch (todo.due) {
      final DateTime date => DateFormat.yMMMd().format(date),
      null => 'no due date',
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.title, style: context.titleMedium),
                  Text(due, style: context.labelMediumHint),
                ],
              ),
            ),
            IconButton(
              onPressed: () => TodoEditSheet.show(context, todo: todo),
              icon: const Icon(Icons.more_vert_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
