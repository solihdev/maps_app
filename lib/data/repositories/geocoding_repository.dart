import 'package:mapping_app/data/models/lat_long.dart';
import 'package:sqflite/sqflite.dart';

class GeoCodingRepository {
  Database? database;
  String tableName = "Location";

  GeoCodingRepository();

  Future<Database> getDb() async {
    if (database == null) {
      database = await createDatabase();
      return database!;
    }
    return database!;
  }

  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = '${databasesPath}location.db';

    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY,"
        "longitude REAL,"
        "lattitude REAL,"
        "dateTime TEXT"
        ")");
  }

  Future addLocation(LocationModel locationModel) async {
    Database db = await getDb();
    var id = await db.insert(tableName, locationModel.toJson());
    print("Add id $id");
    return locationModel.copyWith(id: id);
  }

  Future<List> getLocation() async {
    Database db = await getDb();

    var result = await db.query(tableName,
        columns: ["id", "longitude", "lattitude", "dateTime"]);

    return result.toList();
  }
}
