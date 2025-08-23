import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';

class UpdateBlog implements UseCase<int, UpdateBlogParams> {
  const UpdateBlog(this._blogRepository);

  final BlogRepository _blogRepository;

  @override
  Future<Either<Failure, int>> call(UpdateBlogParams params) async {
    return _blogRepository.updateBlog(params.blog);
  }
}

class UpdateBlogParams {
  const UpdateBlogParams({required this.blog});

  final Blog blog;
}