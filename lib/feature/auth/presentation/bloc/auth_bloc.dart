import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/feature/auth/domain/usecase/user_sign_up.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
    : _userSignUp = userSignUp,
      super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
  }

  _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    response.fold((l) => emit(AuthFailure(l.message)), (r) => AuthSuccess(r));
  }
}
