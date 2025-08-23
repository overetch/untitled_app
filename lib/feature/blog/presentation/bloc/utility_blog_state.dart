part of 'utility_blog_bloc.dart';

enum BlogUtilityEventEnum {
  createBlog,
  updateBlog,
  removeBlog,
}

sealed class BlogUtilityState extends Equatable {
  const BlogUtilityState();
}

final class BlogUtilitySuccess extends BlogUtilityState {
  const BlogUtilitySuccess(this.event);

  final BlogUtilityEventEnum event;

  @override
  List<Object> get props => [event];
}

final class BlogUtilityError extends BlogUtilityState {
  const BlogUtilityError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class BlogUtilityInitial extends BlogUtilityState {
  @override
  List<Object> get props => [];
}

final class BlogUtilityLoading extends BlogUtilityState {
  @override
  List<Object> get props => [];
}
