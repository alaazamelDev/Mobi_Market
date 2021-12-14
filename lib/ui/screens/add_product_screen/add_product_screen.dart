import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:products_management/constants/constants.dart';
import 'package:products_management/data/models/models.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for Form TextFields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // store all discount categories with values
  late List<Discount> discountList = List.generate(3, (index) => Discount());

  // Product name length validation constraint
  static const int _productNameMaxLength = 40; // product name validation

  // product category value
  String _category = 'Other';

  // controller for date picker
  final DateRangePickerController _controller = DateRangePickerController();
  String _date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();

  // Image Picking functionality vars
  dynamic _image;
  final _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'ADD PRODUCT',
        leading: StyledIconButton(
          icon: Icons.close_rounded,
          onPressed: () {
            // show warning dialog
            showWarningDialog();
          },
        ),
        actions: [
          StyledIconButton(
            icon: Icons.check_circle_outline_rounded,
            onPressed: () {
              if (_formKey.currentState!.validate() &&
                  _image != null &&
                  _date !=
                      DateFormat('dd, MMMM yyyy')
                          .format(DateTime.now())
                          .toString()) {
                // todo: perform product insertion request
                print('All Good');
              }
            },
          ),
        ],
      ),
      body: SizedBox(
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
                    maxLength: _productNameMaxLength,
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required';
                      }
                      if (value.length > _productNameMaxLength) {
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: kDefaultVerticalPadding / 2,
                      horizontal: kDefaultHorizontalPadding / 2,
                    ),
                    child: DropdownButtonFormField(
                      hint: Text(
                        'Product Category',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: kBdazzledBlueColor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      isExpanded: true,
                      value: _category,
                      onChanged: (value) {
                        setState(() {
                          _category = value as String;
                        });
                      },
                      items: productCategoriesList
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: kDefaultVerticalPadding),
                  const SectionTitle(title: 'PRODUCT EXPIRY DATE'),
                  SizedBox(height: kDefaultVerticalPadding),
                  SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.single,
                    todayHighlightColor: kOxfordBlueColor,
                    selectionColor: kOxfordBlueColor,
                    onSelectionChanged: selectionChanged,
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
                        _date ==
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
                                _date,
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
                      children: List.generate(
                        discountList.length,
                        (index) => DiscountCategoryCard(
                          discount: discountList[index],
                          valueValidator: (value) {
                            if (discountList[index].valueOfDiscount == -1) {
                              // Required error message
                              return 'Required';
                            }
                            // search if the value is already taken
                            for (int i = 0; i < discountList.length; i++) {
                              if (i != index &&
                                  discountList[i].valueOfDiscount == value) {
                                return 'already taken';
                              }
                            }
                          },
                          categoryValidator: (category) {
                            if (discountList[index].daysOfDiscountCategory ==
                                -1) {
                              // Required error message
                              return 'Required';
                            }
                            // if this category is taken retrn error
                            for (int i = 0; i < discountList.length; i++) {
                              if (i != index &&
                                  discountList[i].daysOfDiscountCategory ==
                                      category) {
                                return 'already taken';
                              }
                            }
                          },
                          onCategoryChanged: (days) {
                            setState(() {
                              // When a new category changed, update it
                              discountList[index].daysOfDiscountCategory =
                                  days!;
                            });
                          },
                          onValueChanged: (disc) {
                            setState(() {
                              // When a new value changed, update it
                              discountList[index].valueOfDiscount = disc!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultVerticalPadding / 2),
                  const SectionTitle(title: 'PRODUCT IMAGES'),
                  SizedBox(height: kDefaultVerticalPadding),
                  _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.file(
                            _image,
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
    );
  }

  // when date selected changes, update the variable
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    // todo: here you can handle the value of expire date

    // if the selected date is before today's date set an error
    // by assigning the selected date to be now, so we can handle the error

    setState(() {
      if ((args.value as DateTime).isBefore(DateTime.now())) {
        _date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
      } else {
        _date = DateFormat('dd, MMMM yyyy').format(args.value).toString();
      }
    });
  }

  // warning dialog before cancel insertion
  void showWarningDialog() {
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
