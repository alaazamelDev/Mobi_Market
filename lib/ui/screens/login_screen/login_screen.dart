import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/ui/screens/home_screen/home_screen.dart';
import 'package:products_management/ui/screens/registration_screen/registration_screen.dart';
import 'package:products_management/ui/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String routeName = 'login_screen';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => LoginScreen(),
    );
  }

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
                SizedBox(height: kDefaultVerticalPadding * 2),
                Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: kOxfordBlueColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: kDefaultVerticalPadding * 2),
                AspectRatio(
                  aspectRatio: ResponsiveDesign(context).getAspectRatio(),
                  child: SvgPicture.asset('assets/images/login.svg'),
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print('pressed');
                            // todo:implement sign in operations
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();
                            print('email: $email ... password: $password');
                            //await AuthServiceProvider().loginUser(email, password);
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          }
                        },
                        backgroundColor: kOxfordBlueColor,
                        textColor: kPlatinumColor,
                        label: 'LOG IN',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: kDefaultVerticalPadding * 2),
                LabeledButton(
                  text: 'Don\'t have an account? ',
                  buttonLabel: 'Sign Up',
                  onButtonPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RegistrationScreen.routeName,
                    );
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
