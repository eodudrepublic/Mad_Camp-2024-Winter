import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../common/util/logger.dart';

class DatabaseHelper {
  // 싱글턴(Singleton) 패턴
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // DB 인스턴스를 얻는 getter
  Future<Database> get database async {
    if (_database != null) {
      Log.info('DB is already opened');
      return _database!;
    }
    String dbName = 'kaist_delivery.db';
    Log.info('DB is not opened yet. Opening DB : $dbName');
    _database = await _initDB(dbName);
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    Directory documentsDirectory;
    // iOS는 getLibraryDirectory, Android는 getApplicationDocumentsDirectory
    if (Platform.isIOS) {
      Log.info('Platform: iOS');
      documentsDirectory = await getLibraryDirectory();
    } else {
      Log.info('Platform: Android');
      documentsDirectory = await getApplicationDocumentsDirectory();
    }

    final dbPath = join(documentsDirectory.path, dbName);

    // DB 오픈
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createDB,
    );
  }

  // DB 테이블 생성
  Future<void> _createDB(Database db, int version) async {
    // pick 테이블 생성
    await db.execute('''
      CREATE TABLE pick (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
    Log.info('DB Table created: pick');
  }
}
