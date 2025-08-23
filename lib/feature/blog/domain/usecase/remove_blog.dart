import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';

class RemoveBlog implements UseCase<bool, int> {
  const RemoveBlog(this._blogRepository);

  final BlogRepository _blogRepository;

  @override
  Future<Either<Failure, bool>> call(int id) async {
    return _blogRepository.removeBlog(id);
  }
}
