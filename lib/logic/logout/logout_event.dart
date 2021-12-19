part of 'logout_bloc.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class LogoutButtonPressed extends LogoutEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'LoginButtonPressed.';
  }
}
