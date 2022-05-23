import 'package:flutter_caicai/common/entitys/entitys.dart';

///点单页店铺详情推荐列表请求
class MenuDetailRecommandlistRequestEntity {
  MenuDetailRecommandlistRequestEntity({
    required this.shopid,
  });

  String shopid;

  factory MenuDetailRecommandlistRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      MenuDetailRecommandlistRequestEntity(
        shopid: json["shopid"],
      );

  Map<String, dynamic> toJson() => {
        "shopid": shopid,
      };
}

///点单页店铺详情推荐列表响应
class MenuDetailRecommandlistResponseEntity {
  MenuDetailRecommandlistResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  String code;
  String msg;
  List<MenuDetailRecommendListDatum> data;

  factory MenuDetailRecommandlistResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      MenuDetailRecommandlistResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: List<MenuDetailRecommendListDatum>.from(
            json["data"].map((x) => MenuDetailRecommendListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MenuDetailRecommendListDatum {
  MenuDetailRecommendListDatum({
    required this.goodslist,
  });

  List<Goodslist> goodslist;

  factory MenuDetailRecommendListDatum.fromJson(Map<String, dynamic> json) =>
      MenuDetailRecommendListDatum(
        goodslist: List<Goodslist>.from(
            json["goodslist"].map((x) => Goodslist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "goodslist": List<dynamic>.from(goodslist.map((x) => x.toJson())),
      };
}
