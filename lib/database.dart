import 'package:sqflite/sqflite.dart';
import 'data.dart';
import 'package:path/path.dart';

final String ColumnId = 'id';
final String ColumnName = 'name';
final String ColumnTitle = 'title';
final String ColumnUrl = 'url';
final String ColumntableTodo = 'table_todo';

class Back {
  late Database db;
  static final Back instance = Back._internal();

  factory Back() {
    return instance;
  }

  Back._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'todo.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table $ColumntableTodo (
  $ColumnId integer primary key autoincrement,
  $ColumnName text not null,
  $ColumnUrl integer not null,
  $ColumnTitle integer not null)
''');
    });
  }

  Future<Data> insertTodo(Data todo) async {
    todo.id = await db.insert(ColumntableTodo, todo.tomap());
    return todo;
  }

  Future<int> deleteTodo(int id) async {
    return await db
        .delete(ColumntableTodo, where: '$ColumnId=?', whereArgs: [id]);
  }

  Future<List<Data>> getAllTodo() async {
    List<Map<String, dynamic>> TodoMaps = await db.query(ColumntableTodo);
    if (TodoMaps.length == 0) {
      return [];
    } else {
      List<Data> todos = [];
      TodoMaps.forEach((element) {
        todos.add(Data.fromMap(element));
      });
      return todos;
    }
  }

  Future<int> updateTodo(Data todo) async {
    return await db.update(ColumntableTodo, todo.tomap(),
        where: '$ColumnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
