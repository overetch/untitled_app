part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();
}

final class BlogLoading extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogError extends BlogState {
  const BlogError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class BlogLoaded extends BlogState {
  const BlogLoaded(this.blogs);

  final List<Blog> blogs;

  @override
  List<Object> get props => [blogs];
}
