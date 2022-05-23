import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/utils/utils.dart';

///用户
class UserAPI {
  ///登录
  static Future<UserLoginResponseEntity> login(
      {required UserLoginRequestEntity params}) async {
    var response = await HttpUtil().post('/user/login', params: params);
    return UserLoginResponseEntity.fromJson(response);
  }
}
