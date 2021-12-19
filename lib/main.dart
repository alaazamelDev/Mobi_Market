import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_management/constants/colors.dart';
import 'package:products_management/constants/route_config.dart';
import 'package:products_management/constants/theme.dart';
import 'package:products_management/data/repositories/auth_repository.dart';
import 'package:products_management/data/repositories/shared_prefs_repository.dart';
import 'package:products_management/logic/auth/auth_bloc.dart';
import 'package:products_management/logic/login/login_bloc.dart';
import 'package:products_management/logic/logout/logout_bloc.dart';
import 'package:products_management/logic/registration/registration_bloc.dart';
import 'package:products_management/ui/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// allow only portrait mode, prevent rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //set color of statusBar to be transparent, and icons to be dark
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final AuthRepository authRepository = AuthRepository(storage);
  final SharedPrefsRepository prefsRepository = SharedPrefsRepository(storage);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(authRepository)..add(AppStarted()),
      ),
      BlocProvider(
        create: (context) => LoginBloc(
          authRepository: authRepository,
          authBloc: context.read<AuthBloc>(),
        ),
      ),
      BlocProvider(
        create: (context) => LogoutBloc(
          prefsRepository: prefsRepository,
          authRepository: authRepository,
          authBloc: context.read<AuthBloc>(),
        ),
      ),
      BlocProvider(
        create: (context) => RegistrationBloc(
          authRepository: authRepository,
          authBloc: context.read<AuthBloc>(),
        ),
      )
    ],
    child: MyApp(authRepository: authRepository),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.authRepository}) : super(key: key);

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product Management',
        theme: theme(),
        color: kOxfordBlueColor,
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            }
            if (state is AuthUnauthenticated) {
              return const WelcomeScreen();
            }
            return const Scaffold(
              body: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    color: kRichBlackColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
