import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/usecase/get_blogs.dart';
import 'package:untitled/feature/blog/domain/usecase/remove_blog.dart';
import 'package:untitled/feature/blog/domain/usecase/save_blog.dart';
import 'package:untitled/feature/blog/domain/usecase/watch_blogs.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc({
    required GetBlogs getBlogs,
    required SaveBlog saveBlog,
    required RemoveBlog removeBlog,
    required WatchBlogs watchBlogs,
  }) : _getBlogs = getBlogs,
       _saveBlog = saveBlog,
       _removeBlog = removeBlog,
       _watchBlogs = watchBlogs,
       super(BlogLoading()) {
    on<_CreateBlog>(_onCreateBlog);
    on<_RemoveBlog>(_onRemoveBlog);
    on<_LoadBlogs>(_onLoadBlog);
    on<_WatchBlogs>(_onWatchBlogs);
  }

  final GetBlogs _getBlogs;
  final RemoveBlog _removeBlog;
  final SaveBlog _saveBlog;
  final WatchBlogs _watchBlogs;

  Future<void> _onCreateBlog(
    _CreateBlog event,
    Emitter<BlogState> emit,
  ) async {}

  Future<void> _onRemoveBlog(
    _RemoveBlog event,
    Emitter<BlogState> emit,
  ) async {}

  Future<void> _onLoadBlog(
    _LoadBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final data = await _getBlogs(NoParams());
    data.fold(
      (error) {
        emit(BlogError(error.message));
      },
      (data) {
        emit(BlogLoaded(data));
      },
    );
  }

  Future<void> _onWatchBlogs(
    _WatchBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final data = _watchBlogs(NoParams());
    data.fold(
      (error) {
        emit(BlogError(error.message));
      },
      (data) async {
        await emit.forEach(data, onData: (data) => BlogLoaded(data));
      },
    );
  }
}
