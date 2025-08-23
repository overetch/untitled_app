part of 'get_blog_bloc.dart';

sealed class GetBlogState extends Equatable {
  const GetBlogState();

  factory GetBlogState.initial() => const GetBlogInitial();

  factory GetBlogState.loading() => const BlogLoading();

  factory GetBlogState.error(String error) => BlogError(error);

  factory GetBlogState.loaded(List<Blog> blogs) => BlogLoaded(blogs);
}

final class GetBlogInitial extends GetBlogState {
  const GetBlogInitial();

  @override
  List<Object> get props => [];
}

final class BlogLoading extends GetBlogState {
  const BlogLoading();

  @override
  List<Object> get props => [];
}

final class BlogError extends GetBlogState {
  const BlogError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class BlogLoaded extends GetBlogState {
  const BlogLoaded(this.blogs);

  final List<Blog> blogs;

  @override
  List<Object> get props => [blogs];
}
