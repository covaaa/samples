import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          ],
        ),
      ),
    );
  }
}
