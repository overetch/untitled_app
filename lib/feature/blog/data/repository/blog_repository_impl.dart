import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/data/data_sources/blog_local_data_source.dart';
import 'package:untitled/feature/blog/data/model/blog_model.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';
import 'package:untitled/feature/blog/domain/usecase/save_blog.dart';

class BlogRepositoryImpl implements BlogRepository {
  BlogRepositoryImpl(this.dataSource);

  final BlogLocalDataSource dataSource;

  @override
  Future<Either<Failure, List<Blog>>> getBlogs() async {
    try {
      return dataSource.getBlogs().then(
        (value) => Right(value.map((e) => e.toEntity()).toList()),
      );
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeBlog(int id) async {
    try {
      final response = await dataSource.removeBlog(id);
      return Right(true);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> saveBlog(BlogModel blog) async {
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
  Future<Either<Failure, bool>> updateBlog(BlogModel blog) async {
    try {
      final response = await dataSource.updateBlog(
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
  Future<Either<Failure, Stream<List<Blog>>>> watchBlogs() async {
    try {
      final response = dataSource.watchBlogs();
      return Right(
        response.map((event) => event.map((e) => e.toEntity()).toList()),
      );
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
