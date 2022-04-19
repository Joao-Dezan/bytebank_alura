import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName ('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'account_number INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase(tableSql);

    return db.insert('$_tableName', _toMap(contact));
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase(tableSql);
    final List<Map<String, dynamic>> result = await db.query('$_tableName');

    return _toList(result);
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];

    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        id: row['$_id'],
        name: row['$_name'],
        accountNumber: row['$_accountNumber'],
      );

      contacts.add(contact);
    }

    return contacts;
  }

  Map<String, dynamic> _toMap(Contact contact) {
    return {'$_name': contact.name, '$_accountNumber': contact.accountNumber};
  }

  void delete(int id) async {
    final Database db = await getDatabase(tableSql);

    db.rawDelete('DELETE FROM $_tableName WHERE $_id = $id');
  }
}
