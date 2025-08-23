import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';

class WatchBlogs implements StreamUseCase<List<Blog>, NoParams> {
  const WatchBlogs(this._blogRepository);

  final BlogRepository _blogRepository;

  @override
  Either<Failure, Stream<List<Blog>>> call(NoParams params) {
    return _blogRepository.watchBlogs();
  }
}