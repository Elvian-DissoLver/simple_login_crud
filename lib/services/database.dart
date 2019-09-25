import 'package:path/path.dart';
import 'package:simple_login_crud/models/User.dart';
import 'package:sqflite/sqflite.dart';

class UsersDatabaseService {
  String path;

  UsersDatabaseService._();

  static final UsersDatabaseService db = UsersDatabaseService._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await init();
    return _database;
  }

  init() async {
    String path = await getDatabasesPath();
    path = join(path, 'users.db');
    print("Entered path $path");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Users (_id INTEGER PRIMARY KEY, username TEXT, password TEXT, date TEXT);');
      print('New table created at $path');
    });
  }

  Future<User> getLogin(String username, String password) async {
    var db = await database;
    var res = await db.rawQuery("SELECT * FROM Users WHERE username = '$username' and password = '$password'");

    User findUser;

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f);
        findUser = User.fromMap(f);
      });
      return findUser;
    }
    return null;
  }

  Future<User> getUser(String username) async {
    var db = await database;
    var res = await db.rawQuery("SELECT * FROM Users WHERE username = '$username'");

    User findUser;

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f);
        findUser = User.fromMap(f);
      });
      return findUser;
    }
    return null;
  }

  Future<List<User>> getUsersFromDB() async {
    final db = await database;
    List<User> usersList = [];
    List<Map> maps = await db.query('Users',
        columns: ['_id', 'username', 'password', 'date']);
    if (maps.length > 0) {
      maps.forEach((map) {
        usersList.add(User.fromMap(map));
      });
    }
    return usersList;
  }

  updateUserInDB(User updatedUser) async {
    final db = await database;
    await db.update('Users', updatedUser.toMap(),
        where: '_id = ?', whereArgs: [updatedUser.id]);
    print('Note updated: ${updatedUser.username} ${updatedUser.password}');
  }

  deleteUserInDB(User userToDelete) async {
    final db = await database;
    await db.delete('Users', where: '_id = ?', whereArgs: [userToDelete.id]);
    print('Note deleted');
  }

  Future addUserInDB(String username, String password) async {
    final db = await database;
    await db.transaction((transaction) {
      transaction.rawInsert(
          'INSERT into Users(username, password, date) VALUES ("${username}", "${password}", "${DateTime.now().toIso8601String()}");');
    });
  }
}
