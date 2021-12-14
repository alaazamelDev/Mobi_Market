import 'package:flutter/material.dart';
import 'package:products_management/constants/constants.dart';

class InformationTile extends StatelessWidget {
  const InformationTile({
    Key? key,
    required this.title,
    required this.informations,
    required this.onTileExpanded,
  }) : super(key: key);
  final String title;
  final List<Widget> informations;
  final Function(bool) onTileExpanded;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15,
          color: kRichBlackColor,
        ),
        onExpansionChanged: onTileExpanded,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultHorizontalPadding,
              vertical: kDefaultVerticalPadding * 0.75,
            ),
            child: Column(
              children: informations,
            ),
          ),
        ],
      ),
    );
  }
}
