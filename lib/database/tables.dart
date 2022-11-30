import 'package:drift/drift.dart';

class Restaurants extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get poster => text()();

  @override
  Set<Column> get primaryKey => {id};
}
