import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:rewo_supplier/configs/app_colors.dart';
import 'package:rewo_supplier/configs/dimensions.dart';


class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? fontColor;
  final Color? strokeColor;
  final Color? decorationColor;
  final TextDecoration? textDecoration;
  final TextStyle? style;
  final int? maxLines;
  const CustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.fontColor,
      this.textAlign,
      this.decorationColor,
      this.textDecoration,
      this.style,
      this.strokeColor,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    final val = fontSize == null
        ? Dimensions.fontSize12 / MediaQuery.textScalerOf(context).scale(1)
        : fontSize! / MediaQuery.textScalerOf(context).scale(1);
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines ?? 5,
      style: style ??
          TextStyle(
              overflow: TextOverflow.ellipsis,
              decoration: textDecoration,
              decorationColor: decorationColor,
              fontSize: val,
              fontWeight: fontWeight ?? FontWeight.w400,
              height: strokeColor != null ? 1.25 : null,
              color: fontColor ?? AppColors.kSubheadingColor,
              shadows: strokeColor == null
                  ? null
                  : outlinedText(strokeColor: strokeColor!, strokeWidth: 1),
              fontFamily: "Montserrat"),
    );
  }

  static TextStyle textStyle({
    final double? fontSize,
    required BuildContext? context,
    final FontWeight? fontWeight,
    final TextAlign? textAlign,
    final Color? fontColor,
    final Color? decorationColor,
    final TextDecoration? textDecoration,
  }) {
    final scale =
        context != null ? MediaQuery.textScalerOf(context).scale(1) : 1.0;

    final val = (fontSize ?? Dimensions.fontSize12) / scale;

    return TextStyle(
        decoration: textDecoration,
        decorationColor: decorationColor,
        fontSize: val,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: fontColor ?? AppColors.kSubheadingColor,
        fontFamily: "Montserrat");
  }

  /// Outlines a text using shadows.
  static List<Shadow> outlinedText(
      {double strokeWidth = 2,
      Color strokeColor = Colors.black,
      int precision = 5}) {
    Set<Shadow> result = HashSet();
    for (int x = 1; x < strokeWidth + precision; x++) {
      for (int y = 1; y < strokeWidth + precision; y++) {
        double offsetX = x.toDouble();
        double offsetY = y.toDouble();
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
      }
    }
    return result.toList();
  }
}
