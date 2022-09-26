import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class SquattTextStyle {
  SquattTextStyle._();

  static FontWeight black = FontWeight.w900;
  static FontWeight bold = FontWeight.w700;
  static FontWeight medium = FontWeight.w500;
  static FontWeight regular = FontWeight.w400;
  static FontWeight light = FontWeight.w300;
  static FontWeight thin = FontWeight.w100;

  static TextStyle caption1 = TextStyle(
      fontSize: 11.sp, color: SquattColor.gunmetal, fontWeight: regular);
  static TextStyle caption2 = TextStyle(
      fontSize: 11.sp, color: SquattColor.coolGrey, fontWeight: regular);
  static TextStyle headLine =
      TextStyle(fontSize: 23.sp, color: SquattColor.blackTwo, fontWeight: bold);
  static TextStyle title1 =
      TextStyle(fontSize: 15.sp, color: SquattColor.blackTwo, fontWeight: bold);
  static TextStyle termsThin =
      TextStyle(fontSize: 10.sp, fontWeight: thin, color: SquattColor.coolGrey);
  static TextStyle termsRegular = TextStyle(
      fontSize: 10.sp, fontWeight: regular, color: SquattColor.coolGrey);
  static TextStyle agreementTextStyle = TextStyle(
      fontSize: 14.sp, fontWeight: regular, color: SquattColor.whiteDf);
  static TextStyle hintStyle = TextStyle(
      fontSize: 15.sp, fontWeight: regular, color: SquattColor.whiteDf);
  static TextStyle body1 = TextStyle(
      fontSize: 15.sp, color: SquattColor.blackTwo, fontWeight: regular);
  static TextStyle button2 =
      TextStyle(fontSize: 13.sp, color: SquattColor.sapphire, fontWeight: bold);
  static TextStyle body2 = TextStyle(
    fontSize: 13.sp,
    color: SquattColor.gunmetal,
    fontWeight: regular,
  );
  static TextStyle body3 = TextStyle(
    fontSize: 13.sp,
    color: SquattColor.blackTwo,
    fontWeight: bold,
  );
  static TextStyle body4 = TextStyle(
    fontSize: 13.sp,
    color: SquattColor.coolGrey,
    fontWeight: regular,
  );
  static TextStyle body5 = TextStyle(
    fontSize: 17.sp,
    color: SquattColor.blackTwo,
    fontWeight: bold,
  );
  static TextStyle button1 =
      TextStyle(fontSize: 13.sp, color: SquattColor.white, fontWeight: bold);
  static TextStyle button3 =
      TextStyle(fontSize: 11.sp, color: SquattColor.sapphire, fontWeight: bold);
  static TextStyle subtitle =
      TextStyle(fontSize: 13.sp, color: SquattColor.gunmetal, fontWeight: bold);
}
