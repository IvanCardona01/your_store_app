import 'package:equatable/equatable.dart';
import 'package:your_store_app/features/auth/models/user_model.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileStarted extends ProfileEvent {
  const ProfileStarted();
}

class ProfileRefreshed extends ProfileEvent {
  const ProfileRefreshed();
}

class ProfileSubmitted extends ProfileEvent {
  final UserModel user;
  const ProfileSubmitted(this.user);

  @override
  List<Object?> get props => [user];
}
