import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/models.dart';
import 'package:products_management/logic/product/product_bloc.dart';
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

  void showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        elevation: 24,
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(DeleteProduct(product!.id!));
              Navigator.pop(context); // close the dialog
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
          'Are you sure you want to delete the product?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get data which passed through navigator
    return Scaffold(
      appBar: MainAppBar(
        actions: [
          StyledIconButton(
            icon: Icons.favorite_border_rounded,
            onPressed: () {
              // todo: add like button pressed event
            },
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
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductDeletetionSucceeded) {
            // Close the screen
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: SizedBox(
            height: ResponsiveDesign(context).getHeight(),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.2,
                        child: Image.network(
                          product!.image_url!,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product name and price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: ResponsiveDesign(context).getWidth() *
                                      0.5,
                                  child: Text(
                                    product!.name!,
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
                                        height: 1.2,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: kDefaultVerticalPadding),

                            // Product Details Section
                            const SectionTitle(
                              title: 'Product Details',
                              color: kRichBlackColor,
                            ),
                            SizedBox(height: kDefaultVerticalPadding),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: kDefaultHorizontalPadding * 0.75),
                              child: Column(
                                children: [
                                  ProductInfoRow(
                                    label: 'Available Quantity',
                                    content: '${product!.quantity}',
                                  ),
                                  SizedBox(height: kDefaultVerticalPadding),
                                  ProductInfoRow(
                                    label: 'Expiry Date',
                                    content: DateFormat('dd MMMM, yyyy').format(
                                        DateTime.parse(product!.exp_date!)),
                                  ),
                                  SizedBox(height: kDefaultVerticalPadding),
                                  ProductInfoRow(
                                    label: 'Category',
                                    content: categoriesList
                                        .where((cat) =>
                                            cat.id == product!.category_id)
                                        .first
                                        .name!,
                                  ),
                                  SizedBox(height: kDefaultVerticalPadding),
                                  ProductInfoRow(
                                    label: 'Views',
                                    content: product!.views!
                                        .toString(), // todo: add views count
                                  ),
                                  SizedBox(height: kDefaultVerticalPadding),
                                  ProductInfoRow(
                                    label: 'Likes',
                                    content: '658'
                                        .toString(), // todo: add likes count
                                  ),
                                  SizedBox(height: kDefaultVerticalPadding),
                                  ProductInfoRow(
                                    label: 'Additional Information',
                                    content: product!.description ??
                                        'Nothing', // todo: add additional information field to product model
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: kDefaultVerticalPadding),
                            const SectionTitle(
                              title: 'Purchase Details',
                              color: kRichBlackColor,
                            ),
                            SizedBox(height: kDefaultVerticalPadding),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: kDefaultHorizontalPadding * 0.75),
                              child: ProductInfoRow(
                                label: 'Phone Number',
                                content: product!.phone_number!,
                              ),
                            ),
                            SizedBox(height: kDefaultVerticalPadding),

                            // if reviews list is empty, hide the reviews section
                            if (product!.reviews_count != 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionTitle(
                                    title: 'Product Reviews',
                                    color: kRichBlackColor,
                                  ),
                                  SizedBox(height: kDefaultVerticalPadding),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            kDefaultHorizontalPadding * 0.75),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: product!.reviews_count,
                                            itemBuilder: (context, index) {
                                              return AspectRatio(
                                                aspectRatio: 1.5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 10,
                                                    top: 8,
                                                    bottom: 8,
                                                    left: 4,
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        kDefaultHorizontalPadding),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                kOxfordBlueColor
                                                                    .withOpacity(
                                                                        0.5),
                                                            offset:
                                                                const Offset(
                                                                    1, 1),
                                                            blurRadius: 3,
                                                            spreadRadius: 1,
                                                          )
                                                        ]),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          product!
                                                              .reviews![index]
                                                              .user!
                                                              .name!,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline5!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      kBdazzledBlueColor),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                kDefaultVerticalPadding *
                                                                    0.5),
                                                        Text(
                                                          product!
                                                              .reviews![index]
                                                              .content!,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    color:
                                                                        kOxfordBlueColor,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            /**
                                   * Add Edit and Delete Buttons to the bottom 
                                   * of the details screen.
                                   */
                            if (product!.is_editable!)
                              Row(
                                children: [
                                  Expanded(
                                    child: FlattedButton(
                                      title: 'EDIT',
                                      onPressed: () {
                                        // Go to the AddProduct Screen in Edit Mode
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      width: kDefaultHorizontalPadding / 2),
                                  Expanded(
                                    child: FlattedButton(
                                      title: 'DELETE',
                                      backgroundColor: Colors.red.shade600,
                                      onPressed: () {
                                        // Perform Delete operation on the product
                                        showWarningDialog(context);
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
