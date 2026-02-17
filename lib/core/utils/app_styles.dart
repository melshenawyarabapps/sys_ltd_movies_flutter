import 'package:flutter/material.dart';
import 'package:sys_ltd_movies_flutter/core/utils/font_sizes.dart';
import 'package:sys_ltd_movies_flutter/core/utils/font_weights.dart';
abstract class AppStyles {
  static TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }

  // regular style

  static TextStyle getBoldStyle({double? fontSize, required Color color}) {
    return _getTextStyle(fontSize ?? FontSizes.s14, FontWeights.bold, color);
  }

  static TextStyle getSemiBoldStyle({double? fontSize, required Color color}) {
    return _getTextStyle(
      fontSize ?? FontSizes.s14,
      FontWeights.semiBold,
      color,
    );
  }

  static TextStyle getRegularStyle({double? fontSize, required Color color}) {
    return _getTextStyle(fontSize ?? FontSizes.s14, FontWeights.regular, color);
  }

  // medium style

  static TextStyle getMediumStyle({double? fontSize, required Color color}) {
    return _getTextStyle(fontSize ?? FontSizes.s14, FontWeights.medium, color);
  }

  // light style

  static TextStyle getLightStyle({double? fontSize, required Color color}) {
    return _getTextStyle(fontSize ?? FontSizes.s14, FontWeights.light, color);
  }
}
