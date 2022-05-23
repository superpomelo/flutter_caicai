import 'package:flutter_caicai/common/entitys/entitys.dart';

///点单页推荐店铺请求
class MenuCommentlistRequestEntity {
  MenuCommentlistRequestEntity({
    required this.lat,
    required this.lon,
  });

  String lat;
  String lon;

  factory MenuCommentlistRequestEntity.fromJson(Map<String, dynamic> json) =>
      MenuCommentlistRequestEntity(
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

//点单页推荐店铺响应数据
class MenuCommentlistResponseEntity {
  MenuCommentlistResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  String code;
  String msg;
  List<MenuDatum> data;

  factory MenuCommentlistResponseEntity.fromJson(Map<String, dynamic> json) =>
      MenuCommentlistResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: List<MenuDatum>.from(
            json["data"].map((x) => MenuDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MenuDatum {
  MenuDatum({
    required this.shopid,
    required this.logourl,
    required this.couponinfo,
    required this.howfar,
    required this.shopname,
    required this.shopaddress,
    required this.goodslist,
  });

  String shopid;
  String logourl;
  String couponinfo;
  String howfar;
  String shopname;
  String shopaddress;
  List<Goodslist> goodslist;

  factory MenuDatum.fromJson(Map<String, dynamic> json) => MenuDatum(
        shopid: json["shopid"],
        logourl: json["logourl"],
        couponinfo: json["couponinfo"],
        howfar: json["howfar"],
        shopname: json["shopname"],
        shopaddress: json["shopaddress"],
        goodslist: List<Goodslist>.from(
            json["goodslist"].map((x) => Goodslist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shopid": shopid,
        "logourl": logourl,
        "couponinfo": couponinfo,
        "howfar": howfar,
        "shopname": shopname,
        "shopaddress": shopaddress,
        "goodslist": List<dynamic>.from(goodslist.map((x) => x.toJson())),
      };
}

// class Goodslist {
//   Goodslist({
//     required this.goodimgurl,
//     required this.goodname,
//     required this.price,
//   });

//   String goodimgurl;
//   String goodname;
//   String price;

//   factory Goodslist.fromJson(Map<String, dynamic> json) => Goodslist(
//         goodimgurl: json["goodimgurl"],
//         goodname: json["goodname"],
//         price: json["price"],
//       );

//   Map<String, dynamic> toJson() => {
//         "goodimgurl": goodimgurl,
//         "goodname": goodname,
//         "price": price,
//       };
// }
