import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.w700,
            color: color ?? kOxfordBlueColor,
            letterSpacing: 0.2,
          ),
    );
  }
}
