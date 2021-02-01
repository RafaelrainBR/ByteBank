import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact_model.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE IF NOT EXISTS $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER'
      ');';

  static const String _tableName = 'Contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'accountNumber';

  Future<int> save(Contact contact) async {
    final db = await getDatabase();

    if (contact.id == null) {
      return db.insert(_tableName, contact.toJson());
    } else {
      return db.rawUpdate('''
        UPDATE $_tableName
        SET $_name=?, $_accountNumber=?
        WHERE $_id = ?
      ''', [contact.name, contact.account, contact.id]);
    }
  }

  Future<int> delete(Contact contact) async {
    final db = await getDatabase();

    return db.delete(_tableName, where: "id=?", whereArgs: [contact.id]);
  }

  Future<List<Contact>> findAll() async {
    final db = await getDatabase();

    return db.query(_tableName).then((maps) {
      return maps.map((e) => Contact.fromJson(e)).toList();
    });
  }
}
