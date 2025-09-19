import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:untitled/core/config/supabase_config.dart';
import 'package:untitled/core/database/app_database.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/feature/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:untitled/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:untitled/feature/auth/domain/repository/auth_repository.dart';
import 'package:untitled/feature/auth/domain/usecase/get_user.dart';
import 'package:untitled/feature/auth/domain/usecase/user_login.dart';
import 'package:untitled/feature/auth/domain/usecase/user_logout.dart';
import 'package:untitled/feature/auth/domain/usecase/user_sign_up.dart';
import 'package:untitled/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:untitled/feature/auth/presentation/bloc/logout_bloc.dart';
import 'package:untitled/feature/blog/data/data_sources/blog_local_data_source.dart';
import 'package:untitled/feature/blog/data/repository/blog_repository_impl.dart';
import 'package:untitled/feature/blog/domain/repository/blog_repository.dart';
import 'package:untitled/feature/blog/domain/usecase/get_blogs.dart';
import 'package:untitled/feature/blog/domain/usecase/remove_blog.dart';
import 'package:untitled/feature/blog/domain/usecase/save_blog.dart';
import 'package:untitled/feature/blog/domain/usecase/update_blog.dart';
import 'package:untitled/feature/blog/domain/usecase/watch_blogs.dart';
import 'package:untitled/feature/blog/presentation/bloc/utility_blog_bloc.dart';
import 'package:untitled/feature/blog/presentation/bloc/get_blog_bloc.dart';

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  final database = AppDatabase();
  DIContainer().registerLazySingleton(create: (r) => supabase.client);
  DIContainer().registerLazySingleton(create: (r) => database);
}

void _initAuth() {
  DIContainer().registerFactory<AuthRemoteDataSource>(
    create: (r) => AuthRemoteDataSourceImpl(r.get()),
  );
  DIContainer().registerFactory<AuthRepository>(
    create: (r) => AuthRepositoryImpl(r.get()),
  );
  DIContainer().registerFactory<UserSignUp>(
    create: (r) => UserSignUp(r.get()),
  );
  DIContainer().registerFactory<UserSignUp>(
    create: (r) => UserSignUp(r.get()),
  );
  DIContainer().registerFactory<UserLogin>(
    create: (r) => UserLogin(r.get()),
  );
  DIContainer().registerFactory<GetUser>(
    create: (r) => GetUser(r.get()),
  );
  DIContainer().registerFactory<UserLogout>(
    create: (r) => UserLogout(r.get()),
  );
  DIContainer().registerFactory<LogoutBloc>(
    create: (r) => LogoutBloc(r.get()),
  );

  DIContainer().registerLazySingleton(
    create: (r) => AuthBloc(
      userSignUp: r.get(),
      userLogin: r.get(),
      userLogout: r.get(),
    ),
  );
}

void _initBlog() {
  DIContainer().registerFactory<BlogLocalDataSource>(
    create: (r) => BlogLocalDataSourceImpl(r.get()),
  );

  DIContainer().registerFactory<BlogRepository>(
    create: (r) => BlogRepositoryImpl(r.get()),
  );

  DIContainer().registerFactory<GetBlogs>(
    create: (r) => GetBlogs(r.get()),
  );
  DIContainer().registerFactory<RemoveBlog>(
    create: (r) => RemoveBlog(r.get()),
  );
  DIContainer().registerFactory<SaveBlog>(
    create: (r) => SaveBlog(r.get()),
  );
  DIContainer().registerFactory<UpdateBlog>(
    create: (r) => UpdateBlog(r.get()),
  );
  DIContainer().registerFactory<WatchBlogs>(
    create: (r) => WatchBlogs(r.get()),
  );
  DIContainer().registerFactory<GetBlogBloc>(
    create: (r) => GetBlogBloc(
      getBlogs: r.get(),
      watchBlogs: r.get(),
    ),
  );

  DIContainer().registerFactory<BlogUtilityBloc>(
    create: (r) => BlogUtilityBloc(
      saveBlog: r.get(),
      removeBlog: r.get(),
    ),
  );

  // BlogLocalDataSource
}
