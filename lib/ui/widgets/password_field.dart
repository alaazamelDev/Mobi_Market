import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:products_management/constants/constants.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final FieldValidator validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordObsecured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: _isPasswordObsecured,
      decoration: InputDecoration(
        filled: true,
        fillColor: kPlatinumColor,
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: kDefaultHorizontalPadding,
            right: kDefaultHorizontalPadding * 0.75,
          ),
          child: Icon(
            Icons.lock,
            size: 25,
            color: kOxfordBlueColor.withOpacity(0.5),
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: kDefaultHorizontalPadding * 0.5,
          ),
          child: IconButton(
            icon: Icon(
              _isPasswordObsecured ? Icons.visibility : Icons.visibility_off,
              size: 25,
              color: kOxfordBlueColor.withOpacity(0.5),
            ),
            onPressed: () {
              setState(() {
                _isPasswordObsecured = !_isPasswordObsecured;
              });
            },
          ),
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey[600]),
        contentPadding: EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding,
          horizontal: kDefaultHorizontalPadding,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
