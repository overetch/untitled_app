abstract class Either<L, R> {
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn);

  bool isLeft();
  bool isRight();
}

class Left<L, R> extends Either<L, R> {
  final L value;

  Left(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) {
    return leftFn(value);
  }

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;
}

class Right<L, R> extends Either<L, R> {
  final R value;

  Right(this.value);

  @override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) {
    return rightFn(value);
  }

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;
}
