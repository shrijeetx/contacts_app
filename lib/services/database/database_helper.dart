import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseHelper{

  static const _databaseName = "contacts.db";
  static const _databaseVersion = 1;

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database?> get database async {
    if(_database == null){
      try{
        _database = await _initDB(_databaseName);
      }on Exception catch(e){
        debugPrint(e.toString());
      }
    }
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getExternalStorageDirectory();
    final path = join(dbPath!.path, filePath);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE contacts(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, phones TEXT)'
    );
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

}