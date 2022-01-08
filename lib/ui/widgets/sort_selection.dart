import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/sort_type_enum.dart';

class SortSelection extends StatefulWidget {
  const SortSelection({
    Key? key,
    required this.onTypeSelected,
  }) : super(key: key);
  final void Function(SortType?) onTypeSelected;

  @override
  State<SortSelection> createState() => _SortSelectionState();
}

class _SortSelectionState extends State<SortSelection> {
  SortType? selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioListTile<SortType>(
          value: SortType.nameSort,
          activeColor: kRichBlackColor,
          groupValue: selected,
          title: Text('Name', style: Theme.of(context).textTheme.headline5),
          onChanged: (type) {
            setState(() {
              selected = type!;
              widget.onTypeSelected(type);
            });
          },
        ),
        RadioListTile<SortType>(
          value: SortType.priceSort,
          activeColor: kRichBlackColor,
          groupValue: selected,
          title: Text('Price', style: Theme.of(context).textTheme.headline5),
          onChanged: (type) {
            setState(() {
              selected = type!;
              widget.onTypeSelected(type);
            });
          },
        ),
        RadioListTile<SortType>(
          value: SortType.quantitySort,
          activeColor: kRichBlackColor,
          groupValue: selected,
          title: Text('Quantity', style: Theme.of(context).textTheme.headline5),
          onChanged: (type) {
            setState(() {
              selected = type!;
              widget.onTypeSelected(type);
            });
          },
        ),
        RadioListTile<SortType>(
          value: SortType.categorySort,
          activeColor: kRichBlackColor,
          groupValue: selected,
          title: Text('Category', style: Theme.of(context).textTheme.headline5),
          onChanged: (type) {
            setState(() {
              selected = type!;
              widget.onTypeSelected(type);
            });
          },
        ),
        RadioListTile<SortType>(
          value: SortType.expDateSort,
          activeColor: kRichBlackColor,
          groupValue: selected,
          title:
              Text('Expiry Date', style: Theme.of(context).textTheme.headline5),
          onChanged: (type) {
            setState(() {
              selected = type!;
              widget.onTypeSelected(type);
            });
          },
        ),
      ],
    );
  }
}
