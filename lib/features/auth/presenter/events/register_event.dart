import '../../models/user_model.dart';

abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final UserModel user;

  RegisterSubmitted({
    required this.user,
  });
}
