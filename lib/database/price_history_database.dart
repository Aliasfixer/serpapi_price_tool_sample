import 'package:path/path.dart';
import 'package:serpapi_price_tool_sample/models/product_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class PriceHistoryDatabase {
  static final PriceHistoryDatabase _instance = PriceHistoryDatabase._internal();

  PriceHistoryDatabase._internal();

  static PriceHistoryDatabase get instance => _instance;

  Database? _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    } else {
      _database = await initDatabase();
      return _database!;
    }
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'serprice', 'database', 'price_history_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE price_history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timestamp TEXT NOT NULL,
        title TEXT NOT NULL,
        thumbnail TEXT NOT NULL,
        price REAL NOT NULL,
        source TEXT NOT NULL
      )
    ''');
  }

  Future<void> batchSaveHistory(List<Product> productList) async {
    final Database db = await database;

    DateTime now = DateTime.now();
    String date = now.toIso8601String();

    final batch = db.batch();

    for (var product in productList) {
      final map = product.toMap(product);
      map['timestamp'] = date;

      batch.insert('price_history', map);
    }

    await batch.commit(noResult: true);
  }
}