import 'package:hive/hive.dart';

part 'info.model.g.dart';

@HiveType(typeId: 1)
class InfoModel {
  @HiveField(0)
  int? count;

  @HiveField(1)
  int? pages;

  @HiveField(2)
  String? next;

  @HiveField(3)
  String? prev;

  InfoModel({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      count: map['count'] as int?,
      pages: map['pages'] as int?,
      next: map['next'] as String?,
      prev: map['prev'] as String?,
    );
  }
}