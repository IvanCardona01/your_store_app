import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_store_app/core/network/models/result.dart';
import 'package:your_store_app/features/profile/interactor/get_profile_use_case.dart';
import 'package:your_store_app/features/profile/interactor/logout_use_case.dart';
import 'package:your_store_app/features/profile/interactor/update_user_use_case.dart';

import 'events/profile_event.dart';
import 'states/profile_state.dart';

class ProfilePresenter extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateUserUseCase _updateProfileUseCase;
  final LogoutUseCase _logoutUseCase;

  ProfilePresenter(
    this._getProfileUseCase,
    this._updateProfileUseCase,
    this._logoutUseCase,
  ) : super(const ProfileInitial()) {
    on<ProfileStarted>(_onProfileStarted);
    on<ProfileRefreshed>(_onProfileRefreshed);
    on<ProfileSubmitted>(_onProfileSubmitted);
    on<ProfileUserDidLogout>(_onProfileUserDidLogout);
  }

  Future<void> _onProfileStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final Result result = await _getProfileUseCase();

    result.when(
      success: (user) {
        if (user == null) {
          emit(const ProfileFailure('Usuario no encontrado'));
        } else {
          emit(ProfileLoaded(user: user));
        }
      },
      failure: (message) => emit(ProfileFailure(message)),
    );
  }

  Future<void> _onProfileRefreshed(
    ProfileRefreshed event,
    Emitter<ProfileState> emit,
  ) async {
    final Result result = await _getProfileUseCase();

    result.when(
      success: (user) {
        if (user == null) {
          emit(const ProfileFailure('Usuario no encontrado'));
        } else {
          emit(ProfileLoaded(user: user));
        }
      },
      failure: (message) => emit(ProfileFailure(message)),
    );
  }

  Future<void> _onProfileSubmitted(
    ProfileSubmitted event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(currentState.copyWith(saving: true));

      final Result result = await _updateProfileUseCase(event.user);
      result.when(
        success: (user) {
          if (user == null) {
            emit(const ProfileFailure('Usuario no encontrado al actualizar'));
          } else {
            emit(ProfileSuccess(user));
            emit(ProfileLoaded(user: user));
          }
        },
        failure: (message) => emit(ProfileFailure(message)),
      );
    }
  }

  Future<void> _onProfileUserDidLogout(
    ProfileUserDidLogout event,
    Emitter<ProfileState> emit,
  ) async {
    final Result result = await _logoutUseCase();
    result.when(
      success: (_) => emit(const ProfileLogout()),
      failure: (message) => emit(ProfileFailure(message)),
    );
  }
}
