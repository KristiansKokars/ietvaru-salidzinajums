import 'package:demo/itemdao.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'Database.g.dart';

class ItemsTable extends Table {
  TextColumn get id => text()();
  TextColumn get url => text()();
  IntColumn get width => integer()();
  IntColumn get height => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [ItemsTable], daos: [ItemsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(

        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
