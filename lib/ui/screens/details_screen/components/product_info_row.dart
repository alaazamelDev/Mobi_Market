import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';


class ProductInfoRow extends StatelessWidget {
  const ProductInfoRow({
    Key? key,
    required this.label,
    required this.content,
  }) : super(key: key);
  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
                color: kBdazzledBlueColor,
              ),
        ),
      ],
    );
  }
}
