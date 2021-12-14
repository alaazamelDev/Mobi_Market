import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/ui/screens/login_screen/login_screen.dart';
import 'package:products_management/ui/widgets/widgets.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);
  static const String routeName = 'registration_screen';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => RegistrationScreen(),
    );
  }

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.99,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultVerticalPadding,
              horizontal: kDefaultHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: kDefaultVerticalPadding * 1.2),
                Text(
                  'Sign Up',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: kOxfordBlueColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: kDefaultVerticalPadding * 2),
                AspectRatio(
                  aspectRatio: ResponsiveDesign(context).getAspectRatio(),
                  child: SvgPicture.asset('assets/images/register.svg'),
                ),
                SizedBox(height: kDefaultVerticalPadding * 2),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        hintText: 'Email Address',
                        controller: _emailController,
                        icon: Icons.alternate_email,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          EmailValidator(errorText: "Enter valid email"),
                        ]),
                      ),
                      SizedBox(height: kDefaultVerticalPadding),
                      CustomTextField(
                        hintText: 'Username',
                        controller: _usernameController,
                        icon: Icons.person,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Required'),
                        ]),
                      ),
                      SizedBox(height: kDefaultVerticalPadding),
                      PasswordField(
                        hintText: 'Password',
                        controller: _passwordController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          MinLengthValidator(6,
                              errorText:
                                  "Password should be atleast 6 characters"),
                          MaxLengthValidator(15,
                              errorText:
                                  "Password should not be greater than 15 characters")
                        ]),
                      ),
                      SizedBox(height: kDefaultVerticalPadding),
                      RoundedCornerButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('signed up');
                          }
                        },
                        backgroundColor: kOxfordBlueColor,
                        textColor: kPlatinumColor,
                        label: 'SIGN UP',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: kDefaultVerticalPadding * 2),
                LabeledButton(
                  text: 'Already have an account? ',
                  buttonLabel: 'Sign in',
                  onButtonPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
