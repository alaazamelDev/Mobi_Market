import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:products_management/constants/constants.dart';

class NotFoundCard extends StatelessWidget {
  const NotFoundCard({
    Key? key,
    required this.title,
    this.imageSource,
  }) : super(key: key);
  final String title;
  final String? imageSource;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 2.5,
          child: SvgPicture.asset(imageSource ?? 'assets/images/no_data.svg'),
        ),
        SizedBox(height: kDefaultVerticalPadding),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
