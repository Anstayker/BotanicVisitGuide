import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  static final SqfliteDatabase _instance = SqfliteDatabase._internal();
  factory SqfliteDatabase() => _instance;
  static Database? _database;

  SqfliteDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    return await openDatabase(
      'botanic_visit_guide.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE zones(zone_id INTEGER PRIMARY KEY, name TEXT)',
        );
        await db.execute(
          'CREATE TABLE waypoint(id INTEGER PRIMARY KEY, zone_id INTEGER, name TEXT, FOREIGN KEY(zone_id) REFERENCES zone_info(id))',
        );
      },
    );
  }
}
