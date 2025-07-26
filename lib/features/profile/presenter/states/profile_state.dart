import 'package:equatable/equatable.dart';
import 'package:your_store_app/core/db/drift/app_database.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final User user;
  final bool saving;

  const ProfileLoaded({
    required this.user,
    this.saving = false,
  });

  ProfileLoaded copyWith({
    User? user,
    bool? saving,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      saving: saving ?? this.saving,
    );
  }

  @override
  List<Object?> get props => [user, saving];
}

class ProfileSuccess extends ProfileState {
  final User user;
  final String message;

  const ProfileSuccess(this.user, {this.message = 'Perfil actualizado correctamente'});

  @override
  List<Object?> get props => [user, message];
}

class ProfileFailure extends ProfileState {
  final String message;
  const ProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}
