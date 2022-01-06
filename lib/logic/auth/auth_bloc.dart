import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_management/data/models/category.dart';
import 'package:products_management/data/repositories/auth_repository.dart';
import 'package:products_management/data/repositories/category_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final CategoryRepository categoryRepository;
  AuthBloc(
    this.authRepository,
    this.categoryRepository,
  ) : super(AuthInitial()) {
    // check if user is already logged in or no
    on<AppStarted>((event, emit) async {
      // get access token from internal storage
      bool isLoggedIn = await authRepository.hasToken();

      if (isLoggedIn) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      await authRepository.presistToken(event.token); // store token

      // get categories list from internal storage
      bool hasCategories = await categoryRepository.hasCategories();
      if (!hasCategories) {
        // if we don't have categories list stored already in the internal storage, then we have to fetch them
        List<Category>? categories =
            await categoryRepository.getAllCategories();
        if (categories != null) {
          await categoryRepository.storeCategoriesToInternalStorage(categories);
          print(categories);
        }
      }
      emit(AuthAuthenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await authRepository.deleteToken();
      emit(AuthUnauthenticated());
    });
  }
}
