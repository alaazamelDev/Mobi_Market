part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFaliure extends LoginState {
  final String error;

  const LoginFaliure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'LoginFaliure {error:$error}';
  }
}
