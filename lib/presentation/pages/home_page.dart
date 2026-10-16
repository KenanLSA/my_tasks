import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_tasks/presentation/providers/todo_providers.dart';
import 'package:my_tasks/presentation/widgets/todo_list.dart';

class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Tasks"), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 32.0,
                ),
                child: TodoList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CreateTodoDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreateTodoDialog extends ConsumerWidget {
  CreateTodoDialog({super.key});

  final _inputFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.read(todoRepositoryProvider);

    return AlertDialog(
      title: Text("Add New Task"),
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
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
        FilledButton(
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
  }
}
