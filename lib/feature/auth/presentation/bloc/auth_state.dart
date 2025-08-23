part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {

  const AuthSuccess(this.user);

  final User user;
}

final class AuthFailure extends AuthState {

  const AuthFailure(this.message);

  final String message;
}

final class AuthLogoutSuccess extends AuthState {}
