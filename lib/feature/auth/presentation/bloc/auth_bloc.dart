import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/feature/auth/domain/entity/user.dart';
import 'package:untitled/feature/auth/domain/usecase/user_logout.dart';
import 'package:untitled/feature/auth/domain/usecase/user_login.dart';
import 'package:untitled/feature/auth/domain/usecase/user_sign_up.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required UserLogout userLogout,
  }) : _userSignUp = userSignUp,
       _userLogout = userLogout,
       _userLogin = userLogin,
       super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserLogout _userLogout;

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => AuthSuccess(user),
    );
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    (await _userLogout(NoParams())).fold(
      (error) => emit(AuthFailure(error.message)),
      (_) => emit(AuthLogoutSuccess()),
    );
  }
}
