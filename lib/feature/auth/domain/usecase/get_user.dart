import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/auth/domain/repository/auth_repository.dart';

class GetUser implements UseCase<Session?, NoParams> {
  GetUser(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, Session?>> call(NoParams params) async {
    try {
      final value = _authRepository.currentSession;
      if (value == null) {
        return Left(Failure('No session'));
      }
      return Right(_authRepository.currentSession);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
