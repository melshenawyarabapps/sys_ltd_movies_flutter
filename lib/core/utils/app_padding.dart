import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppPadding {
  static EdgeInsets verticalPadding(double height) =>
      EdgeInsets.symmetric(vertical: height).h;

  static EdgeInsets horizontalPadding(double width) =>
      EdgeInsets.symmetric(horizontal: width).w;

  static EdgeInsets hvPadding({double height = 0.0, double width = 0.0}) =>
      EdgeInsets.symmetric(horizontal: width.w, vertical: height.h);

  static EdgeInsets get zero => EdgeInsets.zero;

  static EdgeInsetsDirectional onlyPadding({
    double start = 0.0,
    double top = 0.0,
    double end = 0.0,
    double bottom = 0.0,
  }) => EdgeInsetsDirectional.only(
    top: top.h,
    bottom: bottom.h,
    start: start.w,
    end: end.w,
  );

  static EdgeInsetsDirectional all(double all) => EdgeInsetsDirectional.only(
    top: all.h,
    bottom: all.h,
    start: all.w,
    end: all.w,
  );

  static double get p2 => 2;

  static double get p4 => 4;

  static double get p6 => 6;

  static double get p8 => 8;

  static double get p10 => 10;

  static double get p12 => 12;

  static double get p16 => 16;

  static double get p24 => 24;

  static double get p28 => 28;

  static double get p32 => 32;

  static double get p48 => 48;
}
