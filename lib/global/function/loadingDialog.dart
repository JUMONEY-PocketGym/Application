import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          width: 80,
          height: 80,
          child: Center(
            child: Container(
                padding: EdgeInsets.all(5.w),
                child: Lottie.asset(
                  getLoadingAsset(1),
                )),
          ),
        ),
      ),
    );
  }
}

getLoadingAsset(int v) {
  switch (v) {
    case 1:
      return "assets/lottie/loading1.json";

    default:
      return "assets/lottie/loading1.json";
  }
}
