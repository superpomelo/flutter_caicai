/*
 * @Author: yhl
 * @Date: 2022-06-20 08:17:57
 * @LastEditors: yhl
 * @LastEditTime: 2022-07-25 12:07:32
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_caicai/pages/constant/constant.dart';

extension StringExtension on String {
  /// oss完整Url拼接
  String ossUrl() {
    const prefix = Constant.ossUrl;
    if (contains(prefix)) return this;

    return prefix + this;
  }

  /// 图片第一帧
  String videoFirstFrameImage() {
    const suffix = '?x-oss-process=video/snapshot,t_1000,m_fast';
    if (contains(suffix)) return this;

    return this + suffix;
  }

  /// 计算文本size
  Size sizeWithTextStyle(TextStyle style, {int? maxLines}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
