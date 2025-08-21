import 'package:drift/drift.dart';
import 'package:untitled/feature/blog/data/model/blog_model.dart';

@UseRowClass(BlogModel)
class BlogTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().nullable()();

  TextColumn get content => text()();

  DateTimeColumn get createdAt => dateTime().nullable()();
}
