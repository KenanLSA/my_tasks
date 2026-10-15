import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tasks/presentation/providers/todo_providers.dart';

class TodoList extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(todoRepositoryProvider);

    return ref
        .watch(todosProvider)
        .when(
          data: (todos) {
            return todos.isEmpty
                ? Text("No Tasks Created Yet")
                : ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, idx) {
                      return CheckboxListTile(
                        value: todos[idx].isCompleted,
                        onChanged: (val) {
                          repo.toggle(todos[idx]);
                        },
                        title: Text(todos[idx].title),
                      );
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
