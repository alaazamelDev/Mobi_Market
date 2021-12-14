import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';

class StyledIconButton extends StatelessWidget {
  const StyledIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: kRichBlackColor,
      ),
      splashRadius: 20,
      onPressed: onPressed,
    );
  }
}
