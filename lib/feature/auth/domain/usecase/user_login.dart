import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/auth/domain/entity/user.dart';
import 'package:untitled/feature/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  UserLogin(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return _authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  UserLoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
