import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tasks/presentation/providers/todo_providers.dart';
import 'package:my_tasks/presentation/widgets/todo_list.dart';

class HomePage extends ConsumerWidget {
  new({super.key});

  final _inputFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.read(todoRepositoryProvider);

    return Scaffold(
      body: Column(children: [Expanded(child: TodoList())]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add New Task"),
                content: TextFormField(
                  key: _inputFieldKey,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Title"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "The title cannot be empty";
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    repository.create(newValue!);
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_inputFieldKey.currentState!.validate()) return;

                      _inputFieldKey.currentState!.save();
                      _inputFieldKey.currentState!.reset();

                      Navigator.of(context).pop();
                    },
                    child: Text("Save"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
