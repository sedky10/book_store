import 'database.dart';

class Data {
  int? id;
  late String name;
  late String title;
  late String url;

  Data({
    this.id,
    required this.name,
    required this.title,
    required this.url,
  });


  Data.fromMap(Map<String, dynamic> map) {
    if (map[ColumnId] != null) {
      this.id = map[ColumnId];
    }
    this.name = map[ColumnName];
    this.title = map[ColumnTitle];
    this.url = map[ColumnUrl];
  }

  Map<String, dynamic> tomap() {
    Map<String, dynamic> map = {};
    if (this.id != null) {
      map[ColumnId] = this.id;
    }
    map[ColumnName] = this.name;
    map[ColumnTitle] = this.title;
    map[ColumnUrl] = this.url;
    return map;
  }
}
