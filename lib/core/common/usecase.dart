import 'package:untitled/core/common/either.dart';
import 'package:untitled/core/error/failure.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure,Type>> call(Params params);
}

abstract interface class StreamUseCase<Type, Params> {
  Either<Failure, Stream<Type>> call(Params params);
}

class NoParams {

}
