part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {

  factory BlogEvent.load() => const _LoadBlogs();

  factory BlogEvent.createBlog(Blog blog) => _CreateBlog(blog);

  factory BlogEvent.removeBlog(Blog blog) => _RemoveBlog(blog);

  factory BlogEvent.watchBlogs() => const _WatchBlogs();

  const BlogEvent();

  @override
  List<Object?> get props => [];
}

final class _LoadBlogs extends BlogEvent {
  const _LoadBlogs();

  @override
  List<Object?> get props => [];
}

final class _CreateBlog extends BlogEvent {
  const _CreateBlog(this.blog);

  final Blog blog;

  @override
  List<Object?> get props => [blog];
}

final class _RemoveBlog extends BlogEvent {
  const _RemoveBlog(this.blog);

  final Blog blog;

  @override
  List<Object?> get props => [blog];
}

final class _WatchBlogs extends BlogEvent {
  const _WatchBlogs();

  @override
  List<Object?> get props => [];
}
