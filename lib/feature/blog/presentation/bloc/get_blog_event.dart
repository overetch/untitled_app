part of 'get_blog_bloc.dart';

sealed class GetBlogEvent extends Equatable {
  const GetBlogEvent();

  factory GetBlogEvent.watch() => const _WatchBlogs();

  factory GetBlogEvent.get() => const _LoadBlogs();
}

final class _WatchBlogs extends GetBlogEvent {
  const _WatchBlogs();

  @override
  List<Object?> get props => [];
}

final class _LoadBlogs extends GetBlogEvent {
  const _LoadBlogs();

  @override
  List<Object?> get props => [];
}
