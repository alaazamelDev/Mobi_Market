import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/models.dart';
import 'package:products_management/ui/widgets/widgets.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    Key? key,
    required this.onCardPressed,
  }) : super(key: key);
  final Product product;
  final Function() onCardPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 1),
            spreadRadius: 1.5,
            color: Colors.grey.withOpacity(0.12),
          ),
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      height: ResponsiveDesign(context).getHeight() * 0.35,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Image.network(
              product.image_url!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(kDefaultHorizontalPadding * 0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${product.price}',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: kRichBlackColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: kBdazzledBlueColor, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: FlattedButton(
              onPressed: onCardPressed,
              title: 'Show Details',
              icon: Icons.info_outline_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
