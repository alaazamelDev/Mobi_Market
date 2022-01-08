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
    return GestureDetector(
      onTap: onCardPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 1),
              spreadRadius: 2,
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Image.network(
                product.image_url!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(kDefaultHorizontalPadding * 0.4),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name!,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: kRichBlackColor,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${product.new_price}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: kBdazzledBlueColor,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    children: [
                      const Icon(
                        Icons.visibility_outlined,
                        color: kBdazzledBlueColor,
                      ),
                      SizedBox(height: kDefaultHorizontalPadding * 0.3),
                      Text(
                        product.views.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FlattedButton(
              onPressed: onCardPressed,
              title: 'Show Details',
              icon: Icons.info_outline_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
