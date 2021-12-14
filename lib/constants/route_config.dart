import 'package:flutter/material.dart';
import 'package:products_management/ui/screens/home_screen/home_screen.dart';
import 'package:products_management/ui/screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.routeName:
        return WelcomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case RegistrationScreen.routeName:
        return RegistrationScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case AddProductScreen.routeName:
        return AddProductScreen.route();
      case DetailsScreen.routeName:
        return DetailsScreen.route();
      default:
        return error();
    }
  }
}

Route error() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
    ),
  );
}
