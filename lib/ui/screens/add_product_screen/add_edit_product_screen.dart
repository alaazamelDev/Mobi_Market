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
  const AddProductScreen({
    Key? key,
    required this.isEdit,
    this.product,
  }) : super(key: key);
  static const String routeName = 'add_product_screen';
  final bool isEdit;
  final Product? product;

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const AddProductScreen(isEdit: false),
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

  void setupScreenForUpdateMode() {
    print(widget.product!);
    // fill the field with current product information
    _nameController.text = widget.product!.name!;
    _priceController.text = widget.product!.price!.toString();
    _quantityController.text = widget.product!.quantity!.toString();
    _phoneNumberController.text = widget.product!.phone_number!;
    _infoController.text = widget.product!.description!;

    _category = widget.product!.category_id!;
    _date = DateTime.parse(widget.product!.exp_date!);
    _formattedDate = DateFormat('dd, MMMM yyyy').format(_date).toString();

    // fill the number of days property
    discountList = widget.product!.discount_list!.map((discount) {
      discount.numberOfDays = _date.difference(discount.date!).inDays;
      return discount;
    }).toList();
  }

  void updateValuesInProductHolder() {
    String name = _nameController.text;
    double price = double.parse(_priceController.text);
    int quantity = int.parse(_quantityController.text);
    String phone_number = _phoneNumberController.text;
    String description = _infoController.text;
    int cat_id = _category;

    widget.product!.name = name;
    widget.product!.price = price;
    widget.product!.quantity = quantity;
    widget.product!.phone_number = phone_number;
    widget.product!.description = description;
    widget.product!.category_id = cat_id;
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) setupScreenForUpdateMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: widget.isEdit ? 'EDIT PRODUCT' : 'ADD PRODUCT',
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
                int until = 0;
                if (widget.isEdit) {
                  // add the new image url
                  widget.product!.image_url = state.imageUrl;

                  // update values in passed product object
                  updateValuesInProductHolder();

                  until = 3;
                  context
                      .read<ProductBloc>()
                      .add(UpdateProduct(widget.product!));
                } else {
                  // Add Mode

                  // send the product to the api
                  String name = _nameController.text;
                  double price = double.parse(_priceController.text);
                  int quantity = int.parse(_quantityController.text);
                  String phone_number = _phoneNumberController.text;
                  String description = _infoController.text;
                  int cat_id = _category;
                  String exp_date = _date.toIso8601String();

                  List<Discount> discounts = discountList;

                  for (Discount discount in discounts) {
                    discount.date = _date.subtract(Duration(
                      days: discount.numberOfDays!,
                    ));
                  }
                  // new product
                  Product product = Product(
                    name: name,
                    price: price,
                    image_url: state.imageUrl,
                    exp_date: exp_date,
                    category_id: cat_id,
                    quantity: quantity,
                    phone_number: phone_number,
                    description: description,
                    discount_list: discounts,
                  );
                  until = 2;
                  context
                      .read<ProductBloc>()
                      .add(ConfirmProductInsertion(product: product));
                }

                // Go back to tyhe home screen

                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= until);
              }
            },
            child: StyledIconButton(
              icon: Icons.check_circle_outline_rounded,
              onPressed: () {
                // validatge fields for updating product
                if (widget.isEdit && _formKey.currentState!.validate()) {
                  if (_image != null) {
                    uploadImage(context);
                  } else {
                    updateValuesInProductHolder();
                    context
                        .read<ProductBloc>()
                        .add(UpdateProduct(widget.product!));
                  }
                } else
                // validate fields for add product
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
          if (state is ProductInsertionSucceeded ||
              state is ProductUpdateSucceeded) {
            // refresh the data
            context.read<ProductBloc>().add(const GetAllProducts());

            // Go back to the home screen
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
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
                          print(categoryID);
                          _category = categoryID!;
                        });
                      },
                      selectedCategory: _category,
                    ),
                    if (!widget.isEdit) ...[
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
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
                                    if (discountList[index]
                                            .discount_percentage ==
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
                    ],
                    const SectionTitle(title: 'PRODUCT IMAGES'),
                    SizedBox(height: kDefaultVerticalPadding),
                    if (_image == null && widget.isEdit)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          widget.product!.image_url!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                        : !widget.isEdit
                            ? Text(
                                '* select product image',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            : const SizedBox(),
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
