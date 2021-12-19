import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_management/data/repositories/auth_repository.dart';
import 'package:products_management/data/repositories/shared_prefs_repository.dart';
import 'package:products_management/logic/auth/auth_bloc.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository authRepository;
  final SharedPrefsRepository prefsRepository;
  final AuthBloc authBloc;
  LogoutBloc({
    required this.prefsRepository,
    required this.authRepository,
    required this.authBloc,
  }) : super(LogoutInitial()) {
    // implement logout functionality
    on<LogoutButtonPressed>((event, emit) async {
      emit(LogoutLoading());

      // send request
      try {
        final token = await prefsRepository.getAccessToken();
        if (token == null) {
          throw Exception('No Token was found');
        }

        // if token was found delete it
        final message = await authRepository.logout(token);
        if (message == null) {
          throw Exception('Error while deleting token');
        }
        authBloc.add(LoggedOut());
        emit(LogoutInitial());
      } catch (ex) {
        emit(LogoutFaliure(ex.toString()));
      }
    });
  }
}
