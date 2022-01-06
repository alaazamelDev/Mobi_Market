import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/models.dart';
import 'package:products_management/logic/product/product_bloc.dart';
import 'package:products_management/logic/upload/upload_bloc.dart';
import 'package:products_management/ui/screens/add_product_screen/components/category_drop_down_button.dart';
import 'package:products_management/ui/screens/add_product_screen/components/select_image_text_button.dart';
import 'package:products_management/ui/widgets/widgets.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const String routeName = 'add_product_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const AddProductScreen(),
    );
  }

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Controllers for Form TextFields
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _infoController = TextEditingController();

  // store all discount categories with values
  List<Discount> discountList = [];

  // product category value
  int _category = 1;

  // controller for date picker
  String _formattedDate =
      DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
  DateTime _date = DateTime.now();

  // Image Picking functionality vars
  File? _image;
  final _imagePicker = ImagePicker();

  // Loading Dialog
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(color: kRichBlackColor),
          Container(
            margin: EdgeInsets.only(left: kDefaultHorizontalPadding * 0.5),
            child: Text(
              'Image Uploading...',
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

  uploadImage(BuildContext context) {
    // upload the image to the server and get the url
    // then pass it with product
    context.read<UploadBloc>().add(UploadImage(
          file: _image!,
          filename: basename(_image!.path),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'ADD PRODUCT',
        leading: StyledIconButton(
          icon: Icons.close_rounded,
          onPressed: () {
            // show warning dialog
            showWarningDialog(context);
          },
        ),
        actions: [
          BlocListener<UploadBloc, UploadState>(
            listener: (context, state) {
              if (state is UploadLoading) {
                showLoaderDialog(context);
              }
              if (state is UploadFailed) {
                setState(() {
                  _image = null;
                  Navigator.pop(context);
                });
              }
              if (state is UploadSucceeded) {
                // send the product to the api
                String name = _nameController.text;
                double price = double.parse(_priceController.text);
                int quantity = int.parse(_quantityController.text);
                String phone_number = _phoneNumberController.text;
                String description = _infoController.text;
                int cat_id = _category;
                String exp_date = _date.toIso8601String();

                // fill the date field in discount list with properiate data
                List<Discount> discounts = discountList;

                for (Discount discount in discounts) {
                  discount.date = _date.subtract(Duration(
                    days: discount.numberOfDays!,
                  ));
                }

                print(state.imageUrl);
                Product product = Product(
                  name: name,
                  price: price,
                  quantity: quantity,
                  phone_number: phone_number,
                  description: description,
                  category_id: cat_id,
                  exp_date: exp_date,
                  image_url: state.imageUrl,
                  discount_list: discounts,
                );
                context
                    .read<ProductBloc>()
                    .add(ConfirmProductInsertion(product: product));
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              }
            },
            child: StyledIconButton(
              icon: Icons.check_circle_outline_rounded,
              onPressed: () {
                // validate fields
                if (_formKey.currentState!.validate() &&
                    _image != null && // validate image selected
                    _formattedDate != // validate seleceted date
                        DateFormat('dd, MMMM yyyy')
                            .format(DateTime.now())
                            .toString()) {
                  // todo: perform product insertion request
                  uploadImage(context);
                }
              },
            ),
          ),
        ],
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductInsertionSucceeded) {
            // refresh the data
            context.read<ProductBloc>().add(const GetAllProducts());
            Navigator.pop(context);
          }
        },
        child: SizedBox(
          height: ResponsiveDesign(context).getHeight() * 0.9,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: kDefaultVerticalPadding,
                horizontal: kDefaultHorizontalPadding,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SectionTitle(title: 'PRODUCT INFORMATIONS'),
                    _buildTextFormField(
                      context: context,
                      label: 'Name',
                      maxLength: 40,
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        if (value.length > 40) {
                          return 'Name must be less than 40 characters';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      context: context,
                      label: 'Price',
                      controller: _priceController,
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        if (!RegExp(ValidationConstraints.priceRegExPattern)
                            .hasMatch(value)) {
                          return 'Enter valid price value';
                        }
                        return null;
                      },
                    ),
                    // Quantity
                    _buildTextFormField(
                      context: context,
                      label: 'Quantity',
                      inputType: TextInputType.number,
                      controller: _quantityController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }

                        if (!RegExp(ValidationConstraints.quantityRegExPattern)
                            .hasMatch(value)) {
                          return 'Enter valid quantity value';
                        }
                        return null;
                      },
                    ),
                    // Phone number
                    _buildTextFormField(
                      context: context,
                      label: 'Phone Number',
                      controller: _phoneNumberController,
                      inputType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        if (!RegExp(ValidationConstraints.phoneRegExPattern)
                            .hasMatch(value)) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    // Product Desciption
                    _buildTextFormField(
                      context: context,
                      label: 'Additional Info (optional)',
                      controller: _infoController,
                      validator: (value) {
                        return null;
                      },
                    ),
                    CategoryDropDownButton(
                      onCategorySelected: (categoryID) {
                        setState(() {
                          // assign the selected category id to the public variable
                          _category = categoryID!;
                        });
                      },
                      selectedCategory: _category,
                    ),
                    SizedBox(height: kDefaultVerticalPadding),
                    const SectionTitle(title: 'PRODUCT EXPIRY DATE'),
                    SizedBox(height: kDefaultVerticalPadding),
                    SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.single,
                      todayHighlightColor: kOxfordBlueColor,
                      selectionColor: kOxfordBlueColor,
                      onSelectionChanged: onDateSelectionChanged,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultHorizontalPadding / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Selected date:',
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: kOxfordBlueColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          // if the date matches now date
                          _formattedDate ==
                                  DateFormat('dd, MMMM yyyy')
                                      .format(DateTime.now())
                                      .toString()
                              ? Text(
                                  '* select valid date',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                )
                              : Text(
                                  _formattedDate,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: kDefaultVerticalPadding),
                    const SectionTitle(title: 'DISCOUNT DETAILS'),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultHorizontalPadding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: List.generate(
                              discountList.length,
                              (index) => DiscountCategoryCard(
                                index: index,
                                onDismissed: (direction) {
                                  setState(() {
                                    if (direction ==
                                            DismissDirection.startToEnd ||
                                        direction ==
                                            DismissDirection.endToStart) {
                                      discountList.removeAt(index);
                                      print(discountList);
                                    }
                                  });
                                },
                                discount: discountList[index],
                                percentageValidator: (value) {
                                  if (discountList[index].discount_percentage ==
                                      null) {
                                    // Required error message
                                    return 'Required';
                                  }
                                  // search if the value is already taken
                                  for (int i = 0;
                                      i < discountList.length;
                                      i++) {
                                    if (i != index &&
                                        discountList[i].discount_percentage ==
                                            value) {
                                      return 'already taken';
                                    }
                                  }
                                },
                                daysValidator: (day) {
                                  if (discountList[index].numberOfDays ==
                                      null) {
                                    // Required error message
                                    return 'Required';
                                  }
                                  // if this category is taken retrn error
                                  for (int i = 0;
                                      i < discountList.length;
                                      i++) {
                                    if (i != index &&
                                        discountList[i].numberOfDays == day) {
                                      return 'already taken';
                                    }
                                  }
                                },
                                onNumberOfDaysChanged: (days) {
                                  setState(() {
                                    // When a new category changed, update it
                                    discountList[index].numberOfDays = days!;
                                  });
                                },
                                onDiscountPercentageChanged: (disc) {
                                  setState(() {
                                    // When a new value changed, update it
                                    discountList[index].discount_percentage =
                                        disc!;
                                  });
                                },
                              ),
                            ),
                          ),

                          // Add new Discount button
                          FlattedButton(
                            title: '',
                            icon: Icons.add_rounded,
                            onPressed: () {
                              setState(() {
                                // add new discount category
                                discountList.add(Discount());
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kDefaultVerticalPadding / 2),
                    const SectionTitle(title: 'PRODUCT IMAGES'),
                    SizedBox(height: kDefaultVerticalPadding),
                    _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              _image!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Text(
                            '* select product image',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                    SizedBox(height: kDefaultVerticalPadding),
                    SelectImageTextButton(
                      onPressed: () async {
                        XFile? image = await _imagePicker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );
                        setState(() {
                          _image = File(image!.path);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // when date selected changes, update the variable
  void onDateSelectionChanged(args) {
    // todo: here you can handle the value of expire date
    // if the selected date is before today's date set an error
    // by assigning the selected date to be now, so we can handle the error

    setState(() {
      if ((args.value as DateTime).isBefore(DateTime.now())) {
        _date = DateTime.now();
        _formattedDate =
            DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
      } else {
        _date = args.value;
        _formattedDate =
            DateFormat('dd, MMMM yyyy').format(args.value).toString();
      }
    });
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
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
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
          'Are you sure to cancel operation?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int? maxLength,
    TextInputType? inputType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultVerticalPadding / 2,
          horizontal: kDefaultHorizontalPadding / 2),
      child: TextFormField(
        validator: validator,
        controller: controller,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterText: '',
          label: Text(
            label,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: kBdazzledBlueColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
          isDense: true,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kRichBlackColor),
          ),
        ),
        keyboardType: inputType,
      ),
    );
  }
}
