import 'package:your_store_app/core/db/drift/app_database.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;
  RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure(this.message);
}
