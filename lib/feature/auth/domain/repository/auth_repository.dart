import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/auth/domain/entity/user.dart';

abstract interface class AuthRepository {
  Session? get currentSession;

  Future<void> logout();

  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
