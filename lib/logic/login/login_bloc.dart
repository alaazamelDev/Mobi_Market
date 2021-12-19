import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_management/data/repositories/auth_repository.dart';
import 'package:products_management/logic/auth/auth_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthBloc authBloc;
  LoginBloc({required this.authRepository, required this.authBloc})
      : super(LoginInitial()) {
    // implement login functionality
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      // send request
      try {
        final token = await authRepository.login(event.email, event.password);
        if (token == null) {
          throw Exception('Error while fetching token');
        }
        authBloc.add(LoggedIn(token));
        emit(LoginInitial());
      } catch (ex) {
        emit(LoginFaliure(ex.toString()));
      }
    });
  }
}
