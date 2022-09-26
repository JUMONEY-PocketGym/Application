import 'package:flutter/material.dart';

import 'pages/page01/main_page_01.dart';
import 'pages/page02/main_page_02.dart';
import 'pages/page03/main_page_03.dart';
import 'pages/page04/main_page_04.dart';
import 'pages/page05/main_page_05.dart';

class MainBodyFunc extends StatelessWidget {
  final int indexPosition;

  const MainBodyFunc({Key key, this.indexPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (indexPosition) {
      case 0:
        return MainPage01();
        break;
      case 1:
        return MainPage02();
        break;
      case 2:
        return MainPage03();
        break;
      case 3:
        return MainPage04();
        break;
      case 4:
        return MainPage05();
        break;
      default:
    }
    return Container();
  }
}
