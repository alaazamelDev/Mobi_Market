import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_management/data/repositories/auth_repository.dart';
import 'package:products_management/logic/auth/auth_bloc.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;
  RegistrationBloc({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _authRepository = authRepository,
        super(RegistrationInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegistrationLoading());
      try {
        final token = await _authRepository.register(
          event.name,
          event.email,
          event.password,
        );
        if (token == null) {
          throw Exception('Error while registering user');
        }
        _authBloc.add(LoggedIn(token));
        emit(RegistrationInitial());
      } catch (ex) {
        emit(RegistrationFaliure(ex.toString()));
      }
    });
  }
}
