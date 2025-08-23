import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';

class RemoveBlog implements UseCase<int, RemoveBlogParams> {
  const RemoveBlog(this._blogRepository);

  final BlogRepository _blogRepository;

  @override
  Future<Either<Failure, int>> call(RemoveBlogParams params) async {
    return _blogRepository.removeBlog(params.blog);
  }
}

class RemoveBlogParams {
  const RemoveBlogParams({required this.blog});

  final Blog blog;
}