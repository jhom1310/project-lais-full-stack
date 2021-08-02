import 'package:myproject/database/user_database.dart';
import 'package:myproject/model/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;
    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<dynamic> getTokenUser() async {
    final db = await dbProvider.database;
    var result = db.query(userTable, columns: ['access']);
    return result;
  }

  Future<dynamic> getUser() async {
    final db = await dbProvider.database;
    var result = db.query(userTable, columns: ['email']);
    return result;
  }

  Future<dynamic> getTokenUserRefresh() async {
    final db = await dbProvider.database;
    var result = db.query(userTable, columns: ['refresh']);
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
