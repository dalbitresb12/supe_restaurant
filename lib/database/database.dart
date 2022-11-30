import 'package:drift/drift.dart';
import 'package:supe_restaurants/database/connection.dart' as conn;
import 'package:supe_restaurants/database/tables.dart';
import 'package:supe_restaurants/models/restaurant_model.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Restaurants])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(conn.connect());

  @override
  int get schemaVersion => 1;

  Future<bool> existsProductById(int id) async {
    final query = select(restaurants)..where((t) => t.id.equals(id));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<int> insertRestaurant(RestaurantModel item) {
    final entity = RestaurantsCompanion(
      id: Value(item.id),
      title: Value(item.title),
      poster: Value(item.poster),
    );
    return into(restaurants).insert(entity);
  }

  Future<int> deleteRestaurant(int id) {
    final query = delete(restaurants)..where((t) => t.id.equals(id));
    return query.go();
  }
}
