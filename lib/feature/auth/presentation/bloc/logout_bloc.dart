import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled/core/common/usecase.dart';
import 'package:untitled/feature/auth/domain/usecase/user_logout.dart';

part 'logout_event.dart';

part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc(UserLogout userLogout)
    : _userLogout = userLogout,
      super(LogoutStateInitial()) {
    on<_Logout>(_onLogout);
  }

  final UserLogout _userLogout;

  Future<void> _onLogout(_Logout event, Emitter<LogoutState> emit) async {
    emit(LogoutStateLoading());
    (await _userLogout(NoParams())).fold(
      (error) => emit(LogoutStateError(error.message)),
      (_) => emit(LogoutStateSuccess()),
    );
  }
}
