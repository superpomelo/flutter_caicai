/*
 * @Author: yhl
 * @Date: 2022-05-19 13:32:03
 * @LastEditors: yhl
 * @LastEditTime: 2022-07-01 13:14:06
 * @Description: 
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

/// 随机颜色
Color get randColor => Color.fromRGBO(
    Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);

class ToolUtil {
  /// 反转字典
  static Map<String, String> reverseMap(Map<String, String> map) {
    return Map.fromEntries(map.entries.map((e) => MapEntry(e.value, e.key)));
  }
}

/// 函数防抖，带返回值
Function(T) debounceValue<T>(
  Function(T) func, [
  Duration delay = const Duration(milliseconds: 500),
]) {
  Timer? timer;
  return (value) {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func(value);
    });
  };
}

Function() debounce(
  Function() func, [
  Duration delay = const Duration(milliseconds: 500),
]) {
  Timer? timer;
  return () {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func();
    });
  };
}

/// 函数节流
Function(T) throttleValue<T>(
  Future Function(T) func,
) {
  bool enable = true;
  return (value) {
    if (enable == true) {
      enable = false;
      func(value).then((_) {
        enable = true;
      });
    }
  };
}

Function() throttle(
  Future Function() func,
) {
  bool enable = true;
  return () {
    if (enable == true) {
      enable = false;
      func().then((_) {
        enable = true;
      });
    }
  };
}
