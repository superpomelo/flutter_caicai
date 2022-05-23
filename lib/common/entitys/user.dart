// 登录请求
class UserLoginRequestEntity {
  UserLoginRequestEntity({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

//登录返回
class UserLoginResponseEntity {
  UserLoginResponseEntity({
    required this.code,
    required this.data,
    required this.msg,
  });

  String code;
  LoginData data;
  String msg;

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        code: json["code"],
        data: LoginData.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "msg": msg,
      };
}

class LoginData {
  LoginData({
    required this.accesstoken,
    required this.nickname,
    required this.userid,
    required this.userstatus,
    required this.level,
    required this.usericon,
  });
  String accesstoken;
  String nickname;
  String userid;
  String userstatus;
  String level;
  String usericon;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        accesstoken: json["accesstoken"],
        nickname: json["nickname"],
        userid: json["userid"],
        userstatus: json["userstatus"],
        level: json["level"],
        usericon: json["usericon"],
      );

  Map<String, dynamic> toJson() => {
        "accesstoken": accesstoken,
        "nickname": nickname,
        "userid": userid,
        "userstatus": userstatus,
        "level": level,
        "usericon": usericon,
      };
}
