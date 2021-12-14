import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Montserrat',
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline1: TextStyle(
      color: kOxfordBlueColor,
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
    ),
    headline2: TextStyle(
      color: kOxfordBlueColor,
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
    ),
    headline3: TextStyle(
      color: kOxfordBlueColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
    ),
    headline4: TextStyle(
      color: kOxfordBlueColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
    ),
    headline5: TextStyle(
      color: kOxfordBlueColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    headline6: TextStyle(
      color: kOxfordBlueColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.8,
    ),
    bodyText1: TextStyle(
      color: kOxfordBlueColor,
      fontSize: 12.sp,
      fontWeight: FontWeight.w300,
      letterSpacing: 0.8,
    ),
    bodyText2: TextStyle(
      color: kOxfordBlueColor,
      fontSize: 10.sp,
      fontWeight: FontWeight.w300,
      letterSpacing: 0.8,
    ),
  );
}
