import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_management/data/models/models.dart';
import 'package:products_management/logic/logout/logout_bloc.dart';
import 'package:products_management/logic/product/product_bloc.dart';
import 'package:products_management/ui/screens/add_product_screen/add_edit_product_screen.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/ui/screens/screens.dart';
import 'package:products_management/ui/widgets/notfound_card.dart';
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
    context.read<ProductBloc>().add(const GetAllProducts());
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
            onPressed: () {
              // show search scree
              showSearch(context: context, delegate: SearchView());
            },
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (_, state) {
          if (state is ProductInsertionSucceeded ||
              state is ProductDeletetionSucceeded ||
              state is ProductUpdateSucceeded ||
              state is ProductLikeSucceeded) {
            // when new product is inserted we need to fetch the products
            context.read<ProductBloc>().add(const GetAllProducts());
          }
        },
        builder: (context, state) {
          // When data is loaded, show the loaded data in gridview
          if (state is ProductLoaded) {
            if (state.products!.isEmpty) {
              return const NotFoundCard(
                title: 'No data was found!',
              );
            }
            return Column(
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
                      itemCount: state.products!.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: state.products![index],
                          onCardPressed: () async {
                            // todo: increase views count
                            context.read<ProductBloc>().add(IncreaseViews(
                                productID: state.products![index].id!));
                            // todo: move to details screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(
                                  product: state.products![index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          }
          if (state is ProductLoadFailure) {
            // When no data is found or no internet or any exception happen
            return const NotFoundCard(
                title:
                    'An error occured while loading data.\nplease try again later');
          }
          // While loading show cirular progress indicator
          return const Center(
            child: CircularProgressIndicator(
              color: kRichBlackColor,
            ),
          );
        },
      ),
    );
  }
}

class SearchView extends SearchDelegate {
  final List<Product> suggesstionList = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          // clear query field
          query = '';
        },
        splashRadius: 20,
        icon: const Icon(
          Icons.clear,
          color: kRichBlackColor,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      splashRadius: 20,
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: suggesstionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(
            suggesstionList[index].name!,
            style: Theme.of(context).textTheme.headline5,
          ),
        );
      },
    );
  }
}
