import 'dart:async';

import 'package:memo_me/data/data.dart';
import 'package:sqflite/sqflite.dart';

class MemoDatabase {
  static final MemoDatabase instance = MemoDatabase._init();

  static Database? _database;

  static const String databaseName = 'memo.db';
  static const int databaseVersion = 1;

  final String tableTag = 'tag_table';
  final String tableTagContent = 'tag_content_table';

  MemoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final List<String> prepPath = [await getDatabasesPath(), filePath];
    final path = prepPath.join();

    return await openDatabase(path,
        version: databaseVersion, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute('''CREATE TABLE $tableTag (
            ${TagFields.id} $idType,
            ${TagFields.tag} $textType,
            ${TagFields.uid} $textType 
          )''');
    await db.execute('''CREATE TABLE $tableTagContent (
            ${TagContentFields.id} $idType,
            ${TagContentFields.title} $textType,
            ${TagContentFields.content} $textType,
            ${TagContentFields.createdTime} $textType,
            ${TagContentFields.reminderTime} $textType,
            ${TagContentFields.uid} $textType
          )''');
  }

  Future<Tag> insertTag(Tag tag) async {
    final db = await instance.database;

    final id = await db.insert(tableTag, tag.toJson());

    return tag.copy(id: id);
  }

  Future<TagContent> insertTagContent(TagContent tagContent) async {
    final db = await instance.database;

    final id = await db.insert(tableTagContent, tagContent.toJson());

    return tagContent.copy(id: id);
  }

  Future<Tag> readTagwhereId(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTag,
      columns: TagFields.values,
      where: '${TagFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Tag.fromJson(maps.first);
    } else {
      throw Exception('Tag Id $id not found');
    }
  }

  Future<TagContent> readTagContentwhereId(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableTagContent,
        columns: TagContentFields.values,
        where: '${TagContentFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TagContent.fromJson(maps.first);
    } else {
      throw Exception('TagContent Id $id not found');
    }
  }

  Future<List<Tag>> readAllTag() async {
    final db = await instance.database;

    final result = await db.query(tableTag);

    return result.map((json) => Tag.fromJson(json)).toList();
  }

  Future<List<TagContent>> readAllTagContent() async {
    final db = await instance.database;

    final result = await db.query(tableTagContent);

    return result.map((json) => TagContent.fromJson(json)).toList();
  }

  Future<int> updateTag(Tag tag) async {
    final db = await instance.database;

    return db.update(
      tableTag,
      tag.toJson(),
      where: '${TagFields.id} = ?',
      whereArgs: [tag.id],
    );
  }

  Future<int> updateTagContent(TagContent tc) async {
    final db = await instance.database;
    return db.update(tableTagContent, tc.toJson(),
        where: '${TagContentFields.id} = ?', whereArgs: [tc.id]);
  }

  Future<int> deleteTag(int id) async {
    final db = await instance.database;

    return db.delete(
      tableTag,
      where: '${TagFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTagContent(int id) async {
    final db = await instance.database;

    return db.delete(tableTagContent,
        where: '${TagContentFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
