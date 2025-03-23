import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:samples/src/features/todo/state/read.dart';
import 'package:samples/src/features/todo/ui/todo_card.dart';
import 'package:samples/src/features/todo/ui/todo_create_sheet.dart';
import 'package:samples/src/shared/core/core.dart';
import 'package:samples/src/shared/drift/store/store.dart';
import 'package:samples/src/shared/theme/theme.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('Drift')),
          switch (ref.watch(readTodosProvider)) {
            AsyncValue<List<Todo>>(:final valueOrNull?) => SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  List.of(valueOrNull.map(TodoCard.new)),
                ),
              ),
            ),
            AsyncValue(:final error?) => SliverToBoxAdapter(
              child: CustomScrolledCenter(
                children: [Text('Error: $error', style: context.titleMedium)],
              ),
            ),
            AsyncValue<List<Todo>>() => const SliverToBoxAdapter(
              child: CustomScrolledCenter(
                children: [CircularProgressIndicator.adaptive()],
              ),
            ),
          },
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TodoCreateSheet.show(context),
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
