import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_management/constants/colors.dart';
import 'package:products_management/constants/route_config.dart';
import 'package:products_management/constants/theme.dart';
import 'package:products_management/ui/screens/screens.dart';

void main() {
// allow only portrait mode, prevent rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //set color of statusBar to be transparent, and icons to be dark
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product Management',
        theme: theme(),
        color: kOxfordBlueColor,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: WelcomeScreen.routeName,
      ),
    );
  }
}
