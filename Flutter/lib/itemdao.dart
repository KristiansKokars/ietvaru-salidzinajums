import 'package:demo/APIResponse.dart';
import 'package:demo/Database.dart';
import 'package:drift/drift.dart';

part 'itemdao.g.dart';

@DriftAccessor(tables: [ItemsTable])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  ItemsDao(super.db);

  Stream<List<APIResponse>> getAll() {
    return select(itemsTable)
        .map(
          (item) => APIResponse(
            id: item.id,
            url: item.url,
            width: item.width,
            height: item.height,
          ),
        )
        .watch();
  }

  Future<void> addItems(List<APIResponse> items) async {
    await batch((batch) {
      batch.insertAll(
        itemsTable,
        items.map(
          (item) => ItemsTableCompanion.insert(
            id: item.id,
            url: item.url,
            width: item.width,
            height: item.height,
          ),
        ),
      );
    });
  }

  Stream<APIResponse> getItem(String itemId) {
    return (select(itemsTable)..where((item) => item.id.equals(itemId)))
        .map(
          (item) => APIResponse(
            id: item.id,
            url: item.url,
            width: item.width,
            height: item.height,
          ),
        )
        .watchSingle();
  }
}
