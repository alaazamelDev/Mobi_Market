import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:products_management/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.validator,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final FieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: kPlatinumColor,
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: kDefaultHorizontalPadding,
            right: kDefaultHorizontalPadding * 0.75,
          ),
          child: Icon(
            icon,
            size: 25,
            color: kOxfordBlueColor.withOpacity(0.5),
          ),
        ),
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey[600]),
        contentPadding: EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding,
          horizontal: kDefaultHorizontalPadding * 0.5,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
