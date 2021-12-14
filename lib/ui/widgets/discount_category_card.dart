import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/models.dart';

class DiscountCategoryCard extends StatelessWidget {
  DiscountCategoryCard({
    Key? key,
    required this.onValueChanged,
    required this.onCategoryChanged,
    required this.categoryValidator,
    required this.valueValidator,
    required this.discount,
  }) : super(key: key);
  final Discount discount;
  final Function(int?) onCategoryChanged;
  final Function(int?) onValueChanged;
  final String? Function(int?) categoryValidator;
  final String? Function(int?) valueValidator;

  final List<int> categriesList = List.generate(100, (index) => (index + 1));
  final List<int> valuesList = List.generate(20, (index) => (index + 1) * 5);
  @override
  build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultVerticalPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(width: kDefaultHorizontalPadding * 0.75),
          Expanded(
            child: DropdownButtonFormField(
              validator: categoryValidator,
              hint: Text(
                discount.daysOfDiscountCategory == -1
                    ? 'Days'
                    : discount.daysOfDiscountCategory.toString() + ' Day',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              isExpanded: true,
              onChanged: onCategoryChanged,
              items: categriesList
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category == 1 ? '$category Day' : '$category Days',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(width: kDefaultHorizontalPadding),
          Text(
            'Value',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(width: kDefaultHorizontalPadding * 0.75),
          Expanded(
            child: DropdownButtonFormField(
              validator: valueValidator,
              hint: Text(
                discount.valueOfDiscount == -1
                    ? 'Discount'
                    : '${discount.valueOfDiscount} %',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(overflow: TextOverflow.ellipsis),
              ),
              isExpanded: true,
              onChanged: onValueChanged,
              items: valuesList
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(
                          '$value %',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
