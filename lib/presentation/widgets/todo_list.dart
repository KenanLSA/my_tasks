import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tasks/domain/models/todo_model.dart';
import 'package:my_tasks/presentation/providers/todo_providers.dart';

class TodoList extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(todosProvider)
        .when(
          data: (todos) {
            return todos.isEmpty
                ? Text("No Tasks Created Yet")
                : ListView.separated(
                    separatorBuilder: (context, _) =>
                        const SizedBox(height: 8.0),
                    itemCount: todos.length,
                    itemBuilder: (context, idx) {
                      return TodoListTile(todo: todos[idx]);
                    },
                  );
          },
          error: (e, _) {
            return Text("Oops... An Error Occurred");
          },
          loading: () {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            );
          },
        );
  }
}

class TodoListTile extends ConsumerWidget {
  const new({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(todoRepositoryProvider);

    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      onDismissed: (_) {
        repo.delete(todo);
      },
      child: CheckboxListTile(
        value: todo.isCompleted,
        onChanged: (val) {
          repo.toggle(todo);
        },
        title: Text(todo.title),
        tileColor: Theme.of(context).primaryColor.withAlpha(8),
        controlAffinity: ListTileControlAffinity.leading,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
    );
  }
}
