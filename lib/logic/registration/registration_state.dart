part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationFaliure extends RegistrationState {
  final String error;

  const RegistrationFaliure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'RegistrationFaliure {error:$error}';
  }
}
