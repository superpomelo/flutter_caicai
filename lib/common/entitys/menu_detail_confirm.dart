// 确认提交请求
class MenuDetailConfirmRequestEntity {
  MenuDetailConfirmRequestEntity({
    required this.orderid,
    required this.state,
  });

  String orderid;
  String state;

  factory MenuDetailConfirmRequestEntity.fromJson(Map<String, dynamic> json) =>
      MenuDetailConfirmRequestEntity(
        orderid: json["orderid"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "orderid": orderid,
        "state": state,
      };
}

// 确认提交响应
class MenuDetailConfirmResponseEntity {
  MenuDetailConfirmResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  String code;
  String msg;
  String data;

  factory MenuDetailConfirmResponseEntity.fromJson(Map<String, dynamic> json) =>
      MenuDetailConfirmResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data,
      };
}
