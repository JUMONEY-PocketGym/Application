import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'global/function/global_function.dart';

//loading indicator code is a modified and simplified version of this code
//https://github.com/fayaz07/ots

final _tKey = GlobalKey(debugLabel: 'overlay_parent');

/// Updates with the latest [OverlayEntry] child
OverlayEntry _loaderEntry;

/// is dark theme
bool isDarkTheme = false;

/// To keep track if the [Overlay] is shown
bool _loaderShown = false;

class Loading extends StatelessWidget {
  final Widget child;
  final bool darkTheme;

  const Loading({Key key, this.child, this.darkTheme = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    isDarkTheme = darkTheme;
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

OverlayState get _overlayState {
  final context = _tKey.currentContext;
  if (context == null) return null;

  NavigatorState navigator;

  void visitor(Element element) {
    if (navigator != null) return;

    if (element.widget is Navigator) {
      navigator = (element as StatefulElement).state as NavigatorState;
    } else {
      element.visitChildElements(visitor);
    }
  }

  // ignore: unused_element
  context.visitChildElements(visitor);

  assert(navigator != null, '''unable to show overlay''');
  return navigator.overlay;
}

/// To handle a loader for the application
Future<void> showLoadingIndicator(
    {bool isModal = true, Color modalColor}) async {
  try {
    debugPrint('Showing loading overlay');
    final _child = Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        color: Colors.white,
        width: 230.w,
        height: 130.w,
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.w),
                  topRight: Radius.circular(5.w),
                  bottomLeft: Radius.circular(5.w),
                  bottomRight: Radius.circular(5.w),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(5.w),
              child: Scaffold(
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        child: Lottie.asset(
                          getLoadingAsset(1),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "영상 변환 및 업로드 진행중입니다.",
                        style: TextStyle(fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    )
        // SizedBox(
        //   child: CircularProgressIndicator(),
        //   /*(Platform.isAndroid
        //           ? CircularProgressIndicator()
        //           : CupertinoActivityIndicator()),*/
        //   width: 30,
        //   height: 30,
        // ),
        );
    await _showOverlay(
      child: isModal
          ? Stack(
              children: <Widget>[
                ModalBarrier(
                  dismissible: false,
                  color: Colors.black26,
                ),
                _child
              ],
            )
          : _child,
    );
  } catch (err) {
    debugPrint('Exception showing loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> hideLoadingIndicator() async {
  try {
    debugPrint('Hiding loading overlay');
    await _hideOverlay();
  } catch (err) {
    debugPrint('Exception hiding loading overlay');
    throw err;
  }
}

///----------------------------------------------------------------------------
/// These methods deal with showing and hiding the overlay
Future<void> _showOverlay({Widget child}) async {
  try {
    final overlay = _overlayState;

    if (_loaderShown) {
      debugPrint('An overlay is already showing');
      return Future.value(false);
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => child,
    );

    overlay?.insert(overlayEntry);
    _loaderEntry = overlayEntry;
    _loaderShown = true;
  } catch (err) {
    debugPrint('Exception inserting loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> _hideOverlay() async {
  try {
    _loaderEntry.remove();
    _loaderShown = false;
  } catch (err) {
    debugPrint('Exception removing loading overlay\n${err.toString()}');
    throw err;
  }
}

getLoadingAsset(int v) {
  switch (v) {
    case 1:
      return "assets/lottie/loading1.json";
    case 2:
      return "assets/lottie/loading2.json";
    case 3:
      return "assets/lottie/loading3.json";
    case 4:
      return "assets/lottie/loading4.json";
    case 5:
      return "assets/lottie/loading5.json";
    case 6:
      return "assets/lottie/loading6.json";
    case 7:
      return "assets/lottie/loading7.json";
    case 8:
      return "assets/lottie/loading8.json";
    case 9:
      return "assets/lottie/loading9.json";
    case 10:
      return "assets/lottie/loading10.json";
    default:
      return "assets/lottie/loading1.json";
  }
}
