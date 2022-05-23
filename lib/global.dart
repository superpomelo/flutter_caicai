import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_caicai/common/entitys/user.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:admob_flutter/admob_flutter.dart';

/// 全局配置
class Global {
  /// 用户配置

  static UserLoginResponseEntity profile = UserLoginResponseEntity(
      code: "401",
      data: LoginData(
          accesstoken: "401",
          nickname: "",
          userid: "",
          userstatus: "",
          level: "",
          usericon: ""),
      msg: "已失效");

  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 是否离线登录
  static bool isOfflineLogin = false;

  /// 是否 release
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    //admob
    // Initialize without device test ids.
    Admob.initialize();
    // Or add a list of test i
    // Run this before displaying any ad.
    //如果您使用的是iOS，您可能还需要请求跟踪授权才能显示个性化广告：
    Admob.requestTrackingAuthorization().then((value) {
      // ignore: avoid_print
      print(value);
    });

    // 工具初始
    await StorageUtil.init();
    HttpUtil();

// 读取设备第一次打开
    isFirstOpen = !StorageUtil().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (isFirstOpen) {
      StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }
    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = UserLoginResponseEntity.fromJson(_profileJSON);
      isOfflineLogin = true;
    }

    // http 缓存

    // android 状态栏为透明的沉浸
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  // 持久化 用户信息
  static Future<bool> saveProfile(UserLoginResponseEntity userResponse) {
    profile = userResponse;
    return StorageUtil()
        .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }
}
