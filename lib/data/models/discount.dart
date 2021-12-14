class Discount {
  late int _daysOfDiscountCategory = -1; // number of days
  late int _valueOfDiscount = -1; // discount percentage for this category

  int get daysOfDiscountCategory => _daysOfDiscountCategory;

  set daysOfDiscountCategory(int daysOfDiscountCategory) =>
      _daysOfDiscountCategory = daysOfDiscountCategory;

  int get valueOfDiscount => _valueOfDiscount;

  set valueOfDiscount(int valueOfDiscount) =>
      _valueOfDiscount = valueOfDiscount;
}
