import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';

class SelectImageTextButton extends StatelessWidget {
  const SelectImageTextButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(backgroundColor: kRichBlackColor),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding * 0.5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SELECT IMAGE',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: kPlatinumColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: kDefaultHorizontalPadding / 2),
            const Icon(
              Icons.arrow_forward_rounded,
              color: kPlatinumColor,
            ),
          ],
        ),
      ),
    );
  }
}
