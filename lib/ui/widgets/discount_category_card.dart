import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/models.dart';

class DiscountCategoryCard extends StatelessWidget {
  DiscountCategoryCard({
    Key? key,
    required this.onDiscountPercentageChanged,
    required this.onNumberOfDaysChanged,
    required this.discount,
    this.daysValidator,
    this.percentageValidator,
    required this.onDismissed,
    required this.index,
  }) : super(key: key);
  final Discount discount;
  final Function(int?) onNumberOfDaysChanged;
  final Function(double?) onDiscountPercentageChanged;
  final String? Function(int?)? daysValidator;
  final String? Function(double?)? percentageValidator;
  final void Function(DismissDirection direction)? onDismissed;
  final int index;

  final List<int> daysList = List.generate(100, (index) => (index + 1));
  final List<double> valuesList = List.generate(20, (index) => (index + 1) * 5);
  @override
  build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: onDismissed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kDefaultVerticalPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Days',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(width: kDefaultHorizontalPadding * 0.75),
            Expanded(
              child: DropdownButtonFormField(
                validator: daysValidator,
                hint: Text(
                  discount.numberOfDays == null
                      ? 'Days'
                      : discount.numberOfDays.toString() + ' Day',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                isExpanded: true,
                onChanged: onNumberOfDaysChanged,
                items: daysList
                    .map((day) => DropdownMenuItem(
                          value: day,
                          child: Text(
                            day == 1 ? '$day Day' : '$day Days',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(width: kDefaultHorizontalPadding),
            Text(
              'Percent',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(width: kDefaultHorizontalPadding * 0.75),
            Expanded(
              child: DropdownButtonFormField(
                validator: percentageValidator,
                hint: Text(
                  discount.discount_percentage == null
                      ? 'Discount'
                      : '${discount.discount_percentage} %',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(overflow: TextOverflow.ellipsis),
                ),
                isExpanded: true,
                onChanged: onDiscountPercentageChanged,
                value: discount.discount_percentage,
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
      ),
    );
  }
}
