import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/data/model/blog_model.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, List<Blog>>> getBlogs();

  Future<Either<Failure, int>> saveBlog(BlogModel blog);

  Future<Either<Failure, bool>> updateBlog(BlogModel blog);

  Future<Either<Failure, bool>> removeBlog(int id);

  Future<Either<Failure, Stream<List<Blog>>>> watchBlogs();
}
