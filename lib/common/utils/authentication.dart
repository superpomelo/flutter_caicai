import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:flutter_caicai/global.dart';

///检查是否有 token
Future<bool> isAuthenticated() async {
  var protifileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
  return protifileJSON != null ? true : false;
}

///删除缓存 token
Future deleteauthentication() async {
  await StorageUtil().remove(STORAGE_USER_PROFILE_KEY);
  LoginData ldata = LoginData(
      accesstoken: "401",
      nickname: "",
      userid: "",
      userstatus: "",
      level: "",
      usericon: "");
  Global.profile =
      UserLoginResponseEntity(code: "401", data: ldata, msg: "已失效");
}

///重新登录
Future goLoginPage(BuildContext context) async {
  await deleteauthentication();
  Navigator.pushNamedAndRemoveUntil(context, "/sign_in", (route) => false);
}
