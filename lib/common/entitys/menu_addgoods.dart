//购物车添加商品请求
class MenuAddgoodsRequestEntity {
  MenuAddgoodsRequestEntity({
    required this.shopid,
    required this.shopcargoodslist,
    required this.state,
  });

  String shopid;
  String shopcargoodslist;
  String state;

  factory MenuAddgoodsRequestEntity.fromJson(Map<String, dynamic> json) =>
      MenuAddgoodsRequestEntity(
        shopid: json["shopid"],
        shopcargoodslist: json["shopcargoodslist"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "shopid": shopid,
        "shopcargoodslist": shopcargoodslist,
        "state": state,
      };
}

//购物车添加商品响应
// To parse this JSON data, do
//
//     final menuAddgoodsResponseEntity = menuAddgoodsResponseEntityFromJson(jsonString);
class MenuAddgoodsResponseEntity {
  MenuAddgoodsResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  String code;
  String msg;
  Data data;

  factory MenuAddgoodsResponseEntity.fromJson(Map<String, dynamic> json) =>
      MenuAddgoodsResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.orderid,
  });

  String orderid;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderid: json["orderid"],
      );

  Map<String, dynamic> toJson() => {
        "orderid": orderid,
      };
}
