import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, List<Blog>>> getBlogs();

  Future<Either<Failure, int>> saveBlog(Blog blog);

  Future<Either<Failure, int>> updateBlog(Blog blog);

  Future<Either<Failure, int>> removeBlog(Blog blog);

  Either<Failure, Stream<List<Blog>>> watchBlogs();
}
