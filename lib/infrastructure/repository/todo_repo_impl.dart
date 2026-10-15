import 'package:drift/drift.dart';
import 'package:my_tasks/domain/models/todo_model.dart';
import 'package:my_tasks/domain/repo/todo_repo.dart';
import 'package:my_tasks/infrastructure/database/todo_drift.dart';

class TodoRepoImpl implements TodoRepository {
  final AppDatabase _db;

  new({required this._db});

  @override
  Future<void> create(String title) async {
    await _db
        .into(_db.todoItems)
        .insert(TodoItemsCompanion.insert(title: title));
  }

  @override
  Future<void> delete(Todo todo) async {
    await (_db.delete(_db.todoItems)..where((t) => t.id.equals(todo.id))).go();
  }

  @override
  Future<void> toggle(Todo todo) async {
    await (_db.update(_db.todoItems)..where((t) => t.id.equals(todo.id))).write(
      TodoItemsCompanion(isCompleted: Value(!todo.isCompleted)),
    );
  }

  @override
  Stream<List<Todo>> watchAll() {
    return _db
        .select(_db.todoItems)
        .map((t) => Todo(id: t.id, title: t.title, isCompleted: t.isCompleted))
        .watch();
  }
}
