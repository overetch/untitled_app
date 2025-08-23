import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';

class SaveBlog implements UseCase<int, BlogParams> {
  const SaveBlog(this._blogRepository);

  final BlogRepository _blogRepository;

  @override
  Future<Either<Failure, int>> call(BlogParams params) async {
    return _blogRepository.saveBlog();
  }
}

class BlogParams {
  const BlogParams({
    required this.id,
    required this.title,
    required this.description,
  });

  final int id;
  final String title;
  final String description;
}
