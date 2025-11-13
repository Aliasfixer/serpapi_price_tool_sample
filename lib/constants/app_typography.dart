import 'package:flutter/material.dart';

/// 应用字体样式管理
/// 提供全局统一的字体大小定义
/// 基准设备：Pixel 9 Pro XL (高度: 915dp)
class AppTypography {

  /// 巨号文本样式
  static TextStyle gigantic(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 30,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'NotoSansSC',
  );

  /// 超大号文本样式
  static TextStyle grand(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 20,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'NotoSansSC',
  );

  /// 大号文本样式
  static TextStyle big(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 15,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'NotoSansSC',
  );

  /// 中号文本样式
  static TextStyle medium(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 13,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'NotoSansSC',
  );

  /// 小号文本样式
  static TextStyle small(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 12,
    color: color,
    fontWeight: fontWeight?? FontWeight.w400,
    fontFamily: 'NotoSansSC',
  );

  static TextStyle tiny(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 11,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'NotoSansSC',
  );

  static TextStyle micro(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 10,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'NotoSansSC',
  );

  static String notoFontKind() {
    return 'NotoSansSC';
  }

  /// 巨号文本样式
  static TextStyle josefinGigantic(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 30,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'Josefin',
  );

  /// 超大号文本样式
  static TextStyle josefinGrand(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 20,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'Josefin',
  );

  /// 大号文本样式
  static TextStyle josefinBig(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 15,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'Josefin',
  );

  /// 中号文本样式
  static TextStyle josefinMedium(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 13,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'Josefin',
  );

  /// 小号文本样式
  static TextStyle josefinSmall(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 12,
    color: color,
    fontWeight: fontWeight?? FontWeight.w400,
    fontFamily: 'Josefin',
  );

  static TextStyle josefinTiny(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 11,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'Josefin',
  );

  static TextStyle josefinMicro(BuildContext context, {Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 10,
    fontWeight: fontWeight?? FontWeight.w400,
    color: color,
    fontFamily: 'Josefin',
  );

  static String josefinFontKind() {
    return 'Josefin';
  }
}