import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_management/constants/constants.dart';

class LabeledButton extends StatelessWidget {
  const LabeledButton({
    Key? key,
    required this.text,
    required this.buttonLabel,
    required this.onButtonPressed,
  }) : super(key: key);
  final String text;
  final String buttonLabel;
  final Function() onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: kBdazzledBlueColor),
        ),
        SizedBox(width: kDefaultHorizontalPadding * 0.2),
        GestureDetector(
          onTap: onButtonPressed,
          child: Text(
            buttonLabel,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: kOxfordBlueColor, fontSize: 14.sp),
          ),
        ),
        SizedBox(width: kDefaultHorizontalPadding * 0.1),
      ],
    );
  }
}
