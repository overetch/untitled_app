import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  //TODO(Entity) update with user Entity
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
