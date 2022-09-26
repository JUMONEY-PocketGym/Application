import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_toast.dart';

class M {
  static void goToWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static finishApp() =>
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static SharedPreferences _preferences;

  static init() async {
    // print("########################################## M.init0 !!!!");
    _preferences = await _prefs;
    // print("########################################## M.init1 !!!!");
  }

  static void dispose() {
    // _prefs = null;
    // _preferences = null;
  }

  static Future<bool> setString(String name, String value) async {
    var instance = await _prefs;
    return instance.setString(name, value);
  }

  static getString(String key) {
    return _preferences.get(key) ?? "";
  }

  static Future<bool> setInt(String name, int value) async {
    var instance = await _prefs;
    return instance.setInt(name, value);
  }

  static getInt(String key) {
    return _preferences.get(key) ?? 0;
  }

  static Future<bool> setDouble(String name, double value) async {
    var instance = await _prefs;
    return instance.setDouble(name, value);
  }

  static getDouble(String key) {
    return _preferences.get(key) ?? 0.0;
  }

  static Future<bool> setBool(String name, bool value) async {
    var instance = await _prefs;
    return instance.setBool(name, value);
  }

  static getBool(String key) {
    return _preferences.get(key) ?? false;
  }

  static Future<bool> setStringList(String name, List<String> value) async {
    var instance = await _prefs;
    return instance.setStringList(name, value);
  }

  static getStringList(String key) {
    return _preferences.get(key) ?? [""];
  }
}

showBotToast(String message, Color color, Alignment alignment, int seconds) {
  BotToast.showCustomNotification(
      align: alignment,
      duration: Duration(seconds: seconds),
      toastBuilder: (fun) {
        return CustomBotToast(fun: fun, text: message, color: color);
      });
}

hideKeyboard(BuildContext context) {
  print("hide_keyboard");
  FocusScope.of(context).unfocus();
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return Colors.transparent;
    }
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

void copyClipboard(String txt) {
  Clipboard.setData(ClipboardData(text: txt));
  Get.snackbar('알림', '주소가 클립보드에 복사되었습니다');
}
