import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/models.dart';
import 'package:products_management/ui/screens/details_screen/components/information_tile.dart';
import 'package:products_management/ui/screens/details_screen/components/product_info_row.dart';
import 'package:products_management/ui/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, this.product}) : super(key: key);

  static const String routeName = 'details_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const DetailsScreen(),
    );
  }

  final Product? product;
  @override
  Widget build(BuildContext context) {
    // get data which passed through navigator
    return Scaffold(
      appBar: MainAppBar(
        actions: [
          StyledIconButton(
            icon: Icons.favorite_border_rounded,
            onPressed: () {},
          ),
        ],
        title: 'Product Details',
        leading: StyledIconButton(
          icon: Icons.arrow_back_rounded,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: ResponsiveDesign(context).getHeight(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    AspectRatio(
                      aspectRatio: 0.95,
                      child: Image.network(
                        product!.imageUrl,
                        height: ResponsiveDesign(context).getHeight() * 0.45,
                        width: ResponsiveDesign(context).getWidth(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: kDefaultHorizontalPadding,
                        right: kDefaultHorizontalPadding,
                        top: kDefaultVerticalPadding * 1.5,
                        bottom: kDefaultVerticalPadding,
                      ),
                      child: Column(
                        children: [
                          // Product name and price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width:
                                    ResponsiveDesign(context).getWidth() * 0.5,
                                child: Text(
                                  product!.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontFamily: 'Baltica',
                                        overflow: TextOverflow.fade,
                                      ),
                                ),
                              ),
                              Text(
                                '\$${product!.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: kBdazzledBlueColor,
                                        fontFamily: 'Baltica',
                                        letterSpacing: 0.8,
                                        height: 1.2),
                              ),
                            ],
                          ),

                          SizedBox(height: kDefaultVerticalPadding),
                          // Product Details Section
                          InformationTile(
                            title: 'Product Details',
                            onTileExpanded: (isExpanded) {},
                            informations: [
                              ProductInfoRow(
                                label: 'Available Quantity',
                                content: '${product!.quantity}',
                              ),
                              SizedBox(height: kDefaultVerticalPadding),
                              ProductInfoRow(
                                label: 'Expiry Date',
                                content: DateFormat('DD MMMM, yyyy').format(
                                    DateTime.parse(product!.expiryDate)),
                              ),
                              SizedBox(height: kDefaultVerticalPadding),
                              ProductInfoRow(
                                label: 'Category',
                                content: product!.category.name,
                              ),
                              SizedBox(height: kDefaultVerticalPadding),
                              const ProductInfoRow(
                                label: 'Additional Information',
                                content:
                                    'Nothing', // todo: add additional information field to product model
                              ),
                            ],
                          ),
                          InformationTile(
                            title: 'Purchase Details',
                            onTileExpanded: (isExpanded) {},
                            informations: [
                              ProductInfoRow(
                                label: 'Phone Number',
                                content: product!.phoneNumber,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: kOxfordBlueColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultVerticalPadding / 2,
                  ),
                  child: Text(
                    'BUY NOW',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: kPlatinumColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
