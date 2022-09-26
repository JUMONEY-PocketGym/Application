import 'package:flutter/material.dart';

import 'global/value/colors.dart';

class Themes {
  static const String defaultFont = "NotoSansKR";

  ThemeData getAppTheme() {
    return ThemeData(
        colorScheme: const ColorScheme.light(primary: SquattColor.sapphire),
        backgroundColor: SquattColor.white,
        scaffoldBackgroundColor: SquattColor.white,
        fontFamily: defaultFont,
        //TODO add text selection color
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: SquattColor.sapphire,
            selectionColor: SquattColor.sapphire.withOpacity(0.5),
            selectionHandleColor: SquattColor.sapphire));
  }
}
