import 'package:my_tasks/domain/models/todo_model.dart';

abstract class TodoRepository {
  Stream<List<Todo>> watchAll();
  Future<void> create(String title);
  Future<void> toggle(Todo todo);
  Future<void> delete(Todo todo);
}
