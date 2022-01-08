import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/models.dart';
import 'package:products_management/logic/product/product_bloc.dart';
import 'package:products_management/ui/screens/add_product_screen/add_edit_product_screen.dart';
import 'package:products_management/ui/screens/details_screen/components/product_info_row.dart';
import 'package:products_management/ui/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, this.product}) : super(key: key);

  static const String routeName = 'details_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => DetailsScreen(),
    );
  }

  final Product? product;
  final TextEditingController _reviewController = TextEditingController();
  final _reviewFieldKey = GlobalKey<FormState>();

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

  void showAddReviewDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: kDefaultVerticalPadding / 2,
                  horizontal: kDefaultHorizontalPadding / 2),
              child: Form(
                key: _reviewFieldKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    }
                  },
                  controller: _reviewController,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'Add a review',
                    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: kShadowBlueColor,
                          fontWeight: FontWeight.w500,
                        ),
                    isDense: true,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: kRichBlackColor),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            SizedBox(height: kDefaultVerticalPadding),
          ],
        ),
        elevation: 24,
        actions: [
          TextButton(
            onPressed: () {
              // todo: send add review request
              if (_reviewFieldKey.currentState!.validate()) {
                context.read<ProductBloc>().add(AddReview(
                      content: _reviewController.text,
                      productID: product!.id!,
                    ));
                _reviewController.text = "";
                Navigator.pop(context); // close the dialog
              }
            },
            child: Text(
              'Submit',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: kRichBlackColor,
                  ),
            ),
          ),
        ],
        title: Text(
          'Write a Review',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w700),
        ));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => alert,
    );
  }

  @override
  Widget build(BuildContext context) {
    // get data which passed through navigator
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductReviewInsertionFailed) {
          // Show snackbar to tell user
          var snackBar = const SnackBar(
            content: Text('Check your internet connection!!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        appBar: MainAppBar(
          actions: [
            BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
              if (state is ProductLikeSucceeded) {
                product!.liked = !product!.liked!;
              }
            }, builder: (context, state) {
              return StyledIconButton(
                icon: product!.liked!
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                onPressed: () {
                  // todo: add like button pressed event
                  context
                      .read<ProductBloc>()
                      .add(LikeProduct(productID: product!.id!));
                },
              );
            }),
          ],
          title: 'Product Details',
          leading: StyledIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kRichBlackColor,
          splashColor: Colors.grey.shade900,
          child: const Icon(
            Icons.rate_review_outlined,
            color: kPlatinumColor,
          ),
          onPressed: () {
            // todo: show add review dialog
            showAddReviewDialog(context);
          },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        ResponsiveDesign(context).getWidth() *
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
                                    horizontal:
                                        kDefaultHorizontalPadding * 0.75),
                                child: Column(
                                  children: [
                                    ProductInfoRow(
                                      label: 'Available Quantity',
                                      content: '${product!.quantity}',
                                    ),
                                    SizedBox(height: kDefaultVerticalPadding),
                                    ProductInfoRow(
                                      label: 'Expiry Date',
                                      content: DateFormat('dd MMMM, yyyy')
                                          .format(DateTime.parse(
                                              product!.exp_date!)),
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
                                    BlocBuilder<ProductBloc, ProductState>(
                                      builder: (context, state) {
                                        if (state is ProductUpdateSucceeded) {
                                          return ProductInfoRow(
                                            label: 'Views',
                                            content: (product!.views! + 1)
                                                .toString(), // todo: increase views count
                                          );
                                        }
                                        return ProductInfoRow(
                                          label: 'Views',
                                          content: product!.views!
                                              .toString(), // todo: add views count
                                        );
                                      },
                                    ),
                                    SizedBox(height: kDefaultVerticalPadding),
                                    BlocConsumer<ProductBloc, ProductState>(
                                      listener: (context, state) {
                                        if (state is ProductLikeSucceeded) {
                                          if (product!.liked!) {
                                            product!.likes_count =
                                                product!.likes_count == null
                                                    ? 0
                                                    : product!.likes_count! + 1;
                                          } else {
                                            product!.likes_count =
                                                product!.likes_count == null
                                                    ? 0
                                                    : product!.likes_count! - 1;
                                          }
                                        }
                                      },
                                      builder: (context, state) {
                                        return ProductInfoRow(
                                          label: 'Likes',
                                          content: '${product!.likes_count!}'
                                              .toString(), // todo: add likes count
                                        );
                                      },
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
                                    horizontal:
                                        kDefaultHorizontalPadding * 0.75),
                                child: ProductInfoRow(
                                  label: 'Phone Number',
                                  content: product!.phone_number!,
                                ),
                              ),
                              SizedBox(height: kDefaultVerticalPadding),

                              // if reviews list is empty, hide the reviews section
                              BlocConsumer<ProductBloc, ProductState>(
                                listener: (context, state) {
                                  if (state
                                      is ProductReviewInsertionSucceeded) {
                                    context
                                        .read<ProductBloc>()
                                        .add(const GetAllProducts());
                                  }
                                },
                                builder: (context, state) {
                                  if (state is ProductLoaded) {
                                    if (state.products!
                                        .where((pro) => pro.id == product!.id)
                                        .first
                                        .reviews!
                                        .isEmpty) {
                                      return const SizedBox();
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SectionTitle(
                                          title: 'Product Reviews',
                                          color: kRichBlackColor,
                                        ),
                                        SizedBox(
                                            height: kDefaultVerticalPadding),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  kDefaultHorizontalPadding *
                                                      0.75),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: state.products!
                                                      .where((pro) =>
                                                          pro.id == product!.id)
                                                      .first
                                                      .reviews_count,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ReviewCard(
                                                        review: state.products!
                                                            .where((pro) =>
                                                                pro.id ==
                                                                product!.id!)
                                                            .first
                                                            .reviews![index]);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  return const SizedBox();
                                },
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddProductScreen(
                                                isEdit: true,
                                                product: product,
                                              ),
                                            ),
                                          );
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
      ),
    );
  }
}
