import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';
import 'package:sqlite/contact.dart';
import 'package:path/path.dart';

class DBHelper{
  static const _databaseName = 'ContactData.db';
  static const _datebaseVersion = 1;
  Database? _database;
  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }
  initDatabase() async {
    Directory dataDirect = await getApplicationDocumentsDirectory();
    String dpPath = join(dataDirect.path, _databaseName);
    print(dpPath);
    return await openDatabase(dpPath, version: _datebaseVersion, onCreate: _onCreate);
  }
  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Contact.tblContact}(
        ${Contact.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Contact.colName} TEXT NOT NULL,
        ${Contact.colMobile} TEXT NOT NULL
      )
    ''');
  }
  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    return await db.insert(Contact.tblContact, contact.toMap());
  }
  Future<int> deleteContact(Contact contact) async{
    Database db = await database;
    return await db.delete(Contact.tblContact, where: '${Contact.colId}=?',
        whereArgs:[contact.id]);
  }
  
  Future<int> updateContact(Contact contact) async{
    Database db = await database;
    return await db.update(Contact.tblContact, contact.toMap(),
        where: '${Contact.colId}=?', whereArgs:[contact.id]);
  }
  Future<List<Contact>> fecthContact() async{
    Database db = await database;
    List<Map<String, dynamic>> contacts = await db.query(Contact.tblContact);
    return contacts.length == 0 ? []:
    contacts.map((e) => Contact.fromMap(e)).toList();
  }
}