import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:untitled/core/config/supabase_config.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/feature/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:untitled/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:untitled/feature/auth/domain/repository/auth_repository.dart';
import 'package:untitled/feature/auth/domain/usecase/user_login.dart';
import 'package:untitled/feature/auth/domain/usecase/user_sign_up.dart';
import 'package:untitled/feature/auth/presentation/bloc/auth_bloc.dart';

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  DIContainer().registerLazySingleton(create: (r) => supabase.client);
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
  DIContainer().registerFactory<UserLogin>(
    create: (r) => UserLogin(r.get()),
  );
  DIContainer().registerLazySingleton(
    create: (r) => AuthBloc(
      userSignUp: r.get(),
      userLogin: r.get(),
    ),
  );
}
