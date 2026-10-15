import 'package:my_tasks/domain/models/todo_model.dart';
import 'package:my_tasks/domain/repo/todo_repo.dart';
import 'package:my_tasks/infrastructure/repository/todo_repo_impl.dart';
import 'package:my_tasks/presentation/providers/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_providers.g.dart';

@riverpod
TodoRepository todoRepository(Ref ref) =>
    TodoRepoImpl(db: ref.watch(appDatabaseProvider));

@riverpod
Stream<List<Todo>> todos(Ref ref) =>
    ref.watch(todoRepositoryProvider).watchAll();
