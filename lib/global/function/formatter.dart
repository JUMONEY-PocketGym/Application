import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'enums.dart';

class SquattFormatter {
  SquattFormatter._();

  static double adaptableSize(double size, SizeType sizeType) {
    switch (sizeType) {
      case SizeType.height:
        return size.h;
      case SizeType.width:
        return size.w;
      default:
        return size.r;
    }
  }
}
