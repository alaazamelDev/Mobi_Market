import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';

class CategoryDropDownButton extends StatelessWidget {
  const CategoryDropDownButton({
    Key? key,
    required this.onCategorySelected,
    required this.selectedCategory,
  }) : super(key: key);

  final Function(int?) onCategorySelected;
  final int selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: kDefaultVerticalPadding / 2,
        horizontal: kDefaultHorizontalPadding / 2,
      ),
      child: DropdownButtonFormField(
        hint: Text(
          'Product Category',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: kBdazzledBlueColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        isExpanded: true,
        value: selectedCategory,
        onChanged: onCategorySelected,
        items: categoriesList
            .map((category) => DropdownMenuItem(
                  value: category.id,
                  child: Text(
                    category.name!,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
