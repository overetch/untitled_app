import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/usecase/remove_blog.dart';
import 'package:untitled/feature/blog/domain/usecase/save_blog.dart';

part 'utility_blog_event.dart';

part 'utility_blog_state.dart';

class BlogUtilityBloc extends Bloc<BlogUtilityEvent, BlogUtilityState> {
  BlogUtilityBloc({
    required SaveBlog saveBlog,
    required RemoveBlog removeBlog,
  }) : _saveBlog = saveBlog,
       _removeBlog = removeBlog,

       super(BlogUtilityInitial()) {
    on<_CreateBlog>(_onCreateBlog);
    on<_RemoveBlog>(_onRemoveBlog);
  }

  final RemoveBlog _removeBlog;
  final SaveBlog _saveBlog;

  Future<void> _onCreateBlog(
    _CreateBlog event,
    Emitter<BlogUtilityState> emit,
  ) async {
    emit(BlogUtilityLoading());
    final data = await _saveBlog(
      BlogParams(
        title: event.title,
        description: event.description,
      ),
    );
    data.fold(
      (l) => emit(BlogUtilityError(l.message, BlogUtilityEventEnum.createBlog)),
      (r) => emit(const BlogUtilitySuccess(BlogUtilityEventEnum.createBlog)),
    );
  }

  Future<void> _onRemoveBlog(
    _RemoveBlog event,
    Emitter<BlogUtilityState> emit,
  ) async {
    emit(BlogUtilityLoading());

    final data = await _removeBlog(event.id);
    data.fold(
      (l) => emit(BlogUtilityError(l.message, BlogUtilityEventEnum.removeBlog)),
      (r) => emit(const BlogUtilitySuccess(BlogUtilityEventEnum.removeBlog)),
    );
  }
}
