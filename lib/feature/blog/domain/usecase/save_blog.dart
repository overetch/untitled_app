import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';

class SaveBlog implements UseCase<int, SaveBlogParams> {
  const SaveBlog(this._blogRepository);

  final BlogRepository _blogRepository;

  @override
  Future<Either<Failure, int>> call(SaveBlogParams params) async {
    return _blogRepository.saveBlog(params.blog);
  }
}

class SaveBlogParams {
  const SaveBlogParams({required this.blog});

  final Blog blog;
}