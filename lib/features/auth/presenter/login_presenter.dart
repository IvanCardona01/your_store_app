import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../domain/database_service.dart';

class LoginPresenter extends Bloc<LoginEvent, LoginState> {
  final DataBaseService _dbService;

  LoginPresenter(this._dbService) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final user = await _dbService.login(event.email, event.password);
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
