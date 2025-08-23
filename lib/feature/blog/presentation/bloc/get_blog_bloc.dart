import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/domain/usecase/get_blogs.dart';
import 'package:untitled/feature/blog/domain/usecase/watch_blogs.dart';

part 'get_blog_event.dart';

part 'get_blog_state.dart';

class GetBlogBloc extends Bloc<GetBlogEvent, GetBlogState> {
  GetBlogBloc({
    required GetBlogs getBlogs,
    required WatchBlogs watchBlogs,
  }) : _watchBlogs = watchBlogs,
       _getBlogs = getBlogs,
       super(GetBlogState.initial()) {
    on<_LoadBlogs>(_onLoadBlog);
    on<_WatchBlogs>(_onWatchBlogs);
  }

  final GetBlogs _getBlogs;
  final WatchBlogs _watchBlogs;

  Future<void> _onLoadBlog(
    _LoadBlogs event,
    Emitter<GetBlogState> emit,
  ) async {
    final data = await _getBlogs(NoParams());
    data.fold(
      (error) {
        emit(GetBlogState.error(error.message));
      },
      (data) {
        emit(GetBlogState.loaded(data));
      },
    );
  }

  Future<void> _onWatchBlogs(
    _WatchBlogs event,
    Emitter<GetBlogState> emit,
  ) async {
    final data = await _watchBlogs(NoParams());
    data.fold(
      (error) {
        emit(GetBlogState.error(error.message));
      },
      (data) async {
        await emit.forEach(data, onData: (data) => GetBlogState.loaded(data));
      },
    );
  }
}
