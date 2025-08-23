import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/auth/domain/repository/auth_repository.dart';

class UserLogout implements UseCase<void, NoParams> {
  UserLogout(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    try {
      return Right(_authRepository.logout());
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
