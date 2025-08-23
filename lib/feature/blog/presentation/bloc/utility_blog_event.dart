part of 'utility_blog_bloc.dart';

sealed class BlogUtilityEvent extends Equatable {
  const BlogUtilityEvent();

  factory BlogUtilityEvent.createBlog({
    required String title,
    required String description,
  }) => _CreateBlog(title: title, description: description);

  factory BlogUtilityEvent.updateBlog({
    required int id,
    required String title,
    required String description,
  }) => _UpdateBlog(
    id: id,
    title: title,
    description: description,
  );

  factory BlogUtilityEvent.removeBlog(int id) => _RemoveBlog(id);

  @override
  List<Object?> get props => [];
}

final class _CreateBlog extends BlogUtilityEvent {
  const _CreateBlog({required this.title, required this.description});

  final String title;
  final String description;

  @override
  List<Object?> get props => [title, description];
}

final class _UpdateBlog extends BlogUtilityEvent {
  const _UpdateBlog({
    required this.id,
    required this.title,
    required this.description,
  });

  final int id;
  final String title;
  final String description;

  @override
  List<Object?> get props => [id, title, description];
}

final class _RemoveBlog extends BlogUtilityEvent {
  const _RemoveBlog(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
