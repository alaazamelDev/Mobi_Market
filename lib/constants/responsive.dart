import 'package:flutter/cupertino.dart';

class ResponsiveDesign {
  final BuildContext _context;
  ResponsiveDesign(BuildContext context) : _context = context;

  double getHeight() {
    return MediaQuery.of(_context).size.height;
  }
  double getWidth() {
    return MediaQuery.of(_context).size.width;
  }

  double getAspectRatio() {
    var _height = MediaQuery.of(_context).size.height;

    if (_height <= 640) {
      return 2.9;
    } else if (_height > 640 && _height <= 1366) {
      return 2.2;
    }
    return 1.5;
  }
}
