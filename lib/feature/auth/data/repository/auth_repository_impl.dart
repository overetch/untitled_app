import 'package:supabase_flutter/supabase_flutter.dart' show Session;
import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/core/exception/exceptions.dart';
import 'package:untitled/feature/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:untitled/feature/auth/domain/entity/user.dart';
import 'package:untitled/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this.remoteDataSource);

  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.loginUpWithEmailPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
      );
      return Right(response.toUser());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Session? get currentSession => remoteDataSource.currentSession;

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }
}
