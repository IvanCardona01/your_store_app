import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/login_event.dart';
import 'states/login_state.dart';
import '../interactor/login_use_case.dart';

class LoginPresenter extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginPresenter(this._loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final user = await _loginUseCase(event.email, event.password);
      if (user == null) {
        emit(LoginFailure('Credenciales inválidas'));
      } else {
        emit(LoginSuccess(user));
      }
    } catch (e) {
      emit(LoginFailure('Error inesperado'));
    }
  }
}
