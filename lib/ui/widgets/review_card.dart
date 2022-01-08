import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/models.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  final Review? review;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          top: 8,
          bottom: 8,
          left: 4,
        ),
        child: Container(
          padding: EdgeInsets.all(kDefaultHorizontalPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: kOxfordBlueColor.withOpacity(0.5),
                  offset: const Offset(1, 1),
                  blurRadius: 3,
                  spreadRadius: 1,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review!.user!.name!,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: kBdazzledBlueColor),
              ),
              SizedBox(height: kDefaultVerticalPadding * 0.5),
              Text(
                review!.content!,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: kOxfordBlueColor,
                      overflow: TextOverflow.fade,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
