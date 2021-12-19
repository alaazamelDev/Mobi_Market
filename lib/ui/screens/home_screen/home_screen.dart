import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_management/logic/logout/logout_bloc.dart';
import 'package:products_management/ui/screens/add_product_screen/add_product_screen.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/ui/screens/screens.dart';
import 'package:products_management/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'home_screen';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(color: kRichBlackColor),
          Container(
            margin: EdgeInsets.only(left: kDefaultHorizontalPadding * 0.5),
            child: Text(
              'Logging out...',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // warning dialog before cancel insertion
  void showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        elevation: 24,
        actions: [
          TextButton(
            onPressed: () {
              // todo: add LogoutButtonPressede event to logoutBloc
              context.read<LogoutBloc>().add(LogoutButtonPressed());
              Navigator.pop(context);
            },
            child: Text(
              'Yes',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: kRichBlackColor,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: kRichBlackColor,
                  ),
            ),
          ),
        ],
        title: Text(
          'Warning',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'STORE',
        leading: BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state is LogoutLoading) {
              showLoaderDialog(context);
            }
            if (state is LogoutInitial) {
              Navigator.pop(context);
            }
          },
          child: StyledIconButton(
            icon: Icons.logout_rounded,
            onPressed: () {
              showWarningDialog(context);
            },
          ),
        ),
        actions: [
          StyledIconButton(
            icon: Icons.add_rounded,
            onPressed: () {
              Navigator.pushNamed(context, AddProductScreen.routeName);
            },
          ),
          StyledIconButton(
            icon: Icons.search_rounded,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FlattedButton(
                  title: 'Filter',
                  icon: Icons.filter_list_rounded,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: FlattedButton(
                  title: 'Sort by',
                  icon: Icons.sort_rounded,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultHorizontalPadding * 0.4,
                vertical: kDefaultVerticalPadding * 0.4,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: kDefaultHorizontalPadding * 0.4,
                  crossAxisSpacing: kDefaultVerticalPadding * 0.4,
                ),
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: productsList[index],
                    onCardPressed: () {
                      // todo: move to details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(
                            product: productsList[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
