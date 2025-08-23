import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';

class GetBlogs implements UseCase<List<Blog>, NoParams> {
  const GetBlogs(this._blogRepository);

  final BlogRepository _blogRepository;

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return _blogRepository.getBlogs();
  }
}