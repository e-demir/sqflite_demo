import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflitedemo/models/Product.dart';

class DbHelper{

  Database _db;

  Future<Database> get db async{

    if(_db == null){
      _db =await initializeDb();
    }
    return _db;
  }

 Future<Database>initializeDb() async {

    String dbPath = join(await getDatabasesPath(),"eTrade.db");
    var eTradeDb = await openDatabase(dbPath,version: 1,onCreate: createDb);
    return eTradeDb;
 }

  void createDb(Database db, int version) async {
   await db.execute("Create table products(id integer primary key, name text, description text, unitPrice integer)");
  }

  Future<List> getProducts() async{
    Database db = await this.db;
    var result = await db.query("products");
    var list = List.generate(result.length, (index) {
     return Product.fromObject(result[index]);
    });
    return list;
  }

  Future<int> insert(Product product) async{
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }

  Future<int> delete(int id) async{
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM products WHERE id = ${id}");
    return result;
  }

  Future<int> update(Product product) async{
    Database db = await this.db;
    var result = await db.update("products", product.toMap(),where: "id?",whereArgs: [product.id]);
    return result;
  }

}