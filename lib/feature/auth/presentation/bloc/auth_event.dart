part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthSignUp extends AuthEvent {
  const AuthSignUp({
    required this.password,
    required this.email,
    required this.name,
  });

  final String password;
  final String email;
  final String name;
}

final class AuthLogin extends AuthEvent {
  const AuthLogin({required this.password, required this.email});

  final String password;
  final String email;
}
