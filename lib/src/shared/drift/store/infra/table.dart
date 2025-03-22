// coverage:ignore-file

import 'package:drift/drift.dart';

mixin SharedColumn on Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class Todos extends Table with SharedColumn {
  TextColumn get title => text()();
  DateTimeColumn get due => dateTime().nullable()();
}
