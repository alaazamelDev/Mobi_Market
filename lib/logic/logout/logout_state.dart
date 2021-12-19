part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutFaliure extends LogoutState {
  final String error;

  const LogoutFaliure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'LogoutFaliure {error:$error}';
  }
}
