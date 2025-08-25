part of 'logout_bloc.dart';

@immutable
sealed class LogoutEvent {
  const LogoutEvent();

  factory LogoutEvent.logout() => _Logout();
}

final class _Logout extends LogoutEvent {}
