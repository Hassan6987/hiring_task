part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class ToggleObscure extends AuthEvent {}

class ToggleCheck extends AuthEvent{}

class LoginRequested extends AuthEvent {

}