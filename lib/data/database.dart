import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  Database? db;

  Future open() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'coffeeCart.db');

    db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE coffeeCarts (
            id integer primary key autoIncrement,
            image varchar(255) not null,
            title varchar(255) not null,
            extras varchar(255) not null,
            price int not null
          );
        ''');
    });
  }
}
