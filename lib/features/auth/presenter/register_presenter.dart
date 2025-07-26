import 'package:flutter_bloc/flutter_bloc.dart';
import 'events/register_event.dart';
import 'states/register_state.dart';
import '../interactor/register_use_case.dart';

class RegisterPresenter extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUseCase registerUserUseCase;

  RegisterPresenter(this.registerUserUseCase) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegister);
  }

  Future<void> _onRegister(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final user = await registerUserUseCase(
        event.user,
      );
      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
