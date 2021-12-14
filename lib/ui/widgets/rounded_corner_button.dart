import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_management/constants/constants.dart';

class RoundedCornerButton extends StatelessWidget {
  const RoundedCornerButton({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  final Color backgroundColor;
  final Color textColor;
  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding * 0.75,
          horizontal: kDefaultHorizontalPadding / 2,
        ),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: textColor, fontSize: 16.sp),
        ),
      ),
    );
  }
}
