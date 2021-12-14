import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/ui/screens/screens.dart';
import 'package:products_management/ui/widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const String routeName = 'welcome_screen';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const WelcomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding,
          horizontal: kDefaultHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'All You Need\nin One Place',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: kOxfordBlueColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: kDefaultVerticalPadding * 4),
            AspectRatio(
              aspectRatio: 1.8,
              child: SvgPicture.asset('assets/images/shopping.svg'),
            ),
            SizedBox(height: kDefaultVerticalPadding * 4),
            RoundedCornerButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              backgroundColor: kOxfordBlueColor,
              textColor: kPlatinumColor,
              label: 'LOG IN',
            ),
            SizedBox(height: kDefaultVerticalPadding / 2),
            RoundedCornerButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.routeName);
              },
              backgroundColor: kPlatinumColor,
              textColor: kOxfordBlueColor,
              label: 'SIGN UP',
            ),
          ],
        ),
      ),
    );
  }
}
