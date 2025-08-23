import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/blog/data/model/blog_model.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';

class UpdateBlog implements UseCase<bool, UpdateBlogParams> {
  const UpdateBlog(this._blogRepository);

  final BlogRepository _blogRepository;

  @override
  Future<Either<Failure, bool>> call(UpdateBlogParams params) async {
    final model = BlogModel(
      title: params.blog.title,
      content: params.blog.content,
      createdAt: params.blog.createdAt,
    );
    return _blogRepository.updateBlog(model);
  }
}

class UpdateBlogParams {
  const UpdateBlogParams({required this.blog});

  final Blog blog;
}
