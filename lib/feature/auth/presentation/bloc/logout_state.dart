part of 'logout_bloc.dart';

@immutable
sealed class LogoutState {
  const LogoutState();
}

final class LogoutStateInitial extends LogoutState {}

final class LogoutStateLoading extends LogoutState {}

final class LogoutStateSuccess extends LogoutState {}

final class LogoutStateError extends LogoutState {
  const LogoutStateError(this.message);

  final String message;
}
