import 'package:untitled/core/database/app_database.dart';
import 'package:untitled/feature/blog/data/model/blog_model.dart';
import 'package:untitled/feature/blog/domain/usecase/save_blog.dart';

abstract interface class BlogLocalDataSource {
  Future<List<BlogModel>> getBlogs();

  Future<int> saveBlog(BlogModel blog);

  Future<bool> updateBlog(BlogModel blog);

  Future<int> removeBlog(int blog);

  Stream<List<BlogModel>> watchBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  BlogLocalDataSourceImpl(this.database);

  final AppDatabase database;

  @override
  Stream<List<BlogModel>> watchBlogs() {
    return database.select(database.blogTable).watch();
  }

  @override
  Future<List<BlogModel>> getBlogs() async {
    return database.select(database.blogTable).get();
  }

  @override
  Future<int> removeBlog(int id) {
    return (database.delete(
      database.blogTable,
    )..where((item) => database.blogTable.id.equals(id))).go();
  }

  @override
  Future<int> saveBlog(BlogModel blog) async {
    return database.into(database.blogTable).insert(blog);
  }

  @override
  Future<bool> updateBlog(BlogModel blog) async {
    return database.managers.blogTable.replace(blog);
  }
}
