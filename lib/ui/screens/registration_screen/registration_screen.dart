import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/logic/registration/registration_bloc.dart';
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
    _registrationButtonPressed() {
      String name = _usernameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text;

      // add register event to registration bloc
      context.read<RegistrationBloc>().add(
            RegisterButtonPressed(
              name: name,
              email: email,
              password: password,
            ),
          );
    }

    return Scaffold(
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationFaliure) {
            var snackBar = const SnackBar(
              content: Text('Registration Faild, validate your credentials'),
              duration: Duration(
                milliseconds: 500,
              ),
            );

            // show snackBar to tell user that login has faild
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is RegistrationInitial) {
            Navigator.pop(context);
          }
        },
        child: SizedBox(
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
                        BlocBuilder<RegistrationBloc, RegistrationState>(
                          builder: (context, state) {
                            if (state is RegistrationLoading) {
                              return RoundedCornerButton(
                                onPressed: () {},
                                backgroundColor: kOxfordBlueColor,
                                loadingWidget: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: kDefaultVerticalPadding * 0.5,
                                    horizontal: kDefaultHorizontalPadding / 2,
                                  ),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: kPlatinumColor,
                                  ),
                                ),
                              );
                            }
                            return RoundedCornerButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _registrationButtonPressed();
                                }
                              },
                              backgroundColor: kOxfordBlueColor,
                              textColor: kPlatinumColor,
                              label: 'SIGN UP',
                            );
                          },
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
      ),
    );
  }
}
