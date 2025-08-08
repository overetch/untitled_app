import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  UserSignUp(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await _authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;
}
