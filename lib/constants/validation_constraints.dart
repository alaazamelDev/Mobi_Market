class ValidationConstraints {
  // phone pattern
  static const String phoneRegExPattern =
      '^[\\+]?[(]?[0-9]{3}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}\$';

  // quantity patter
  static const String quantityRegExPattern = '^0\$|^[1-9][0-9]*\$';

  // price pattern
  static const String priceRegExPattern = '^\\d{0,8}(\\.\\d{1,4})?\$';
}
