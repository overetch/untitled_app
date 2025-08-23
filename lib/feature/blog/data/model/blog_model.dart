import 'package:drift/drift.dart';
import 'package:untitled/core/database/app_database.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';

class BlogModel extends Insertable<BlogModel> {
  BlogModel({
    required this.title,
    required this.content,
    required this.createdAt,
    this.id,
  });

  final int? id;
  final String? title;
  final String content;
  final DateTime? createdAt;

  Blog toEntity() {
    return Blog(id: id!, title: title, content: content, createdAt: createdAt);
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return BlogTableCompanion(
      title: Value(title),
      content: Value(content),
      createdAt: Value(createdAt),
    ).toColumns(nullToAbsent);
  }
}
