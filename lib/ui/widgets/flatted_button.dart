import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';

class FlattedButton extends StatelessWidget {
  const FlattedButton({
    Key? key,
    required this.title,
    this.icon,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final IconData? icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: kPlatinumColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kShadowBlueColor,
          ),
          SizedBox(width: kDefaultHorizontalPadding / 2),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: kShadowBlueColor, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
