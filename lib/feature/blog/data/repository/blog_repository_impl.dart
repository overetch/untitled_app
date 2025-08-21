import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/data/data_sources/blog_local_data_source.dart';
import 'package:untitled/feature/blog/data/model/blog_model.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  BlogRepositoryImpl(this.dataSource);

  final BlogLocalDataSource dataSource;

  Future<Either<Failure, T>> _wrapper<T>(Future<T> Function() fn) async {
    try {
      final response = await fn();
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getBlogs() async {

    final blogModels = await _wrapper<List<BlogModel>>(dataSource.getBlogs);
    try {
      return dataSource.getBlogs().then(
        (value) => Right(value.map((e) => e.toEntity()).toList()),
      );
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> removeBlog(Blog blog) async {
    try {
      final response = await dataSource.removeBlog(
        BlogModel(
          title: blog.title,
          content: blog.content,
          createdAt: blog.createdAt,
        ),
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> saveBlog(Blog blog) async {
    try {
      final response = await dataSource.saveBlog(
        BlogModel(
          title: blog.title,
          content: blog.content,
          createdAt: blog.createdAt,
        ),
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }

  }

  @override
  Future<Either<Failure, int>> updateBlog(Blog blog) {
    // TODO: implement updateBlog
    throw UnimplementedError();
  }

  @override
  Either<Failure, Stream<List<Blog>>> watchBlogs() {
    // TODO: implement watchBlogs
    throw UnimplementedError();
  }
}
