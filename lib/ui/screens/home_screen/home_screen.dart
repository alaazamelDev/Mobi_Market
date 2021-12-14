import 'package:products_management/data/models/models.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'STORE',
        leading: StyledIconButton(
          icon: Icons.menu_rounded,
          onPressed: () {},
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
