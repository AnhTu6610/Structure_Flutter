import 'package:flutter/foundation.dart';
import 'package:structure_example/models/response_model/product_detail_res.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteProvider {
  final String _CARTDB = kReleaseMode ? "CARTDB" : "CARTDBDEV";
  static Database database;
  Future openDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _CARTDB);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE $_CARTDB(id TEXT PRIMARY KEY, avatar TEXT, name TEXT, price INTEGER, priceDiscount INTEGER, amount INTEGER)');
      },
    );
  }

  Future<int> deleteProductInCart(Product product) async => database.delete("$_CARTDB", where: 'id = ?', whereArgs: [product.sId]);

  Future<int> insertProductIToCart(Product product) async {
    String sql =
        'INSERT INTO $_CARTDB(id, avatar, name, price, priceDiscount, amount) VALUES("${product.sId}", "${product.avatar}", "${product.name}", "${product.price}", "${product.priceDiscount}", "${product.amount}")';
    return await database.transaction((txn) async => await txn.rawInsert(sql));
  }

  Future<Product> getProductById(String idProduct) async {
    List<Map<String, dynamic>> list = await database.query('$_CARTDB', where: 'id = ?', whereArgs: [idProduct]);
    if (list.length == 0) return null;
    return Product.fromJson(list[0]);
  }

  Future<List<Product>> getAllProductInCart() async {
    List<Map<String, dynamic>> list = await database.query('$_CARTDB');
    if (list.length == 0) return [];
    return list.map((e) => Product.fromJson(e)).toList();
  }

  Future<void> updateProductInCart(Product product) async {
    Map<String, dynamic> values = {
      "id": product.sId,
      "avatar": product.avatar,
      "name": product.name,
      "price": product.price,
      "priceDiscount": product.priceDiscount,
      "amount": product.amount,
    };
    await database.update('$_CARTDB', values, where: 'id = ?', whereArgs: [product.sId]);
  }

  Future deleteCart() async {
    database.delete("$_CARTDB");
  }

  Future close() async => database.close();
}
