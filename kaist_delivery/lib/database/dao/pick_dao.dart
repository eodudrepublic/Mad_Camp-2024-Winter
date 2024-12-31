import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';
import '../model/pick_model.dart';

class PickDao {
  final dbHelper = DatabaseHelper.instance;

  // CREATE
  Future<int> insertPick(PickModel pick) async {
    final Database db = await dbHelper.database;
    return await db.insert(
      'pick',
      pick.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ (전체 조회)
  Future<List<PickModel>> getAllPicks() async {
    final Database db = await dbHelper.database;
    final List<Map<String, dynamic>> result = await db.query('pick');
    return result.map((map) => PickModel.fromMap(map)).toList();
  }

  // READ (단일 조회)
  Future<PickModel?> getPickById(int id) async {
    final Database db = await dbHelper.database;
    final List<Map<String, dynamic>> result = await db.query(
      'pick',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return PickModel.fromMap(result.first);
    }
    return null;
  }

  // UPDATE
  Future<int> updatePick(PickModel pick) async {
    final Database db = await dbHelper.database;
    return await db.update(
      'pick',
      pick.toMap(),
      where: 'id = ?',
      whereArgs: [pick.id],
    );
  }

  // DELETE (단일)
  Future<int> deletePick(int id) async {
    final Database db = await dbHelper.database;
    return await db.delete(
      'pick',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE (전체)
  Future<int> deleteAllPicks() async {
    final Database db = await dbHelper.database;
    return await db.delete('pick');
  }

  // DELETE: 특정 이름으로
  Future<int> deleteByName(String name) async {
    final db = await dbHelper.database;
    return await db.delete(
      'pick',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  // UPDATE: oldName → newName
  Future<int> updateName(String oldName, String newName) async {
    final db = await dbHelper.database;
    return await db.update(
      'pick',
      {'name': newName},
      where: 'name = ?',
      whereArgs: [oldName],
    );
  }
}
