import 'package:drift/drift.dart';

class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 3)();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
}
