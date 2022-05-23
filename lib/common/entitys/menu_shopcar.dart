//购物车请求
class MenuShopcarRequestEntity {
  MenuShopcarRequestEntity({
    required this.shopid,
  });

  String shopid;

  factory MenuShopcarRequestEntity.fromJson(Map<String, dynamic> json) =>
      MenuShopcarRequestEntity(
        shopid: json["shopid"],
      );

  Map<String, dynamic> toJson() => {
        "shopid": shopid,
      };
}

//购物车响应数据
// class MenuShopcarResponseEntity {
//   MenuShopcarResponseEntity({
//     required this.code,
//     required this.msg,
//     required this.data,
//   });

//   String code;
//   String msg;
//   List<ShopCarDatum> data;

//   factory MenuShopcarResponseEntity.fromJson(Map<String, dynamic> json) =>
//       MenuShopcarResponseEntity(
//         code: json["code"],
//         msg: json["msg"],
//         data: List<ShopCarDatum>.from(
//             json["data"].map((x) => ShopCarDatum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "msg": msg,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class ShopCarDatum {
//   ShopCarDatum({
//     required this.shopcartotalnum,
//     required this.shopcartotalamount,
//     required this.discountinfo,
//     required this.shopcargoodslist,
//   });

//   String shopcartotalnum;
//   String shopcartotalamount;
//   String discountinfo;
//   List<Shopcargoodslist> shopcargoodslist;

//   factory ShopCarDatum.fromJson(Map<String, dynamic> json) => ShopCarDatum(
//         shopcartotalnum: json["shopcartotalnum"],
//         shopcartotalamount: json["shopcartotalamount"],
//         discountinfo: json["discountinfo"],
//         shopcargoodslist: List<Shopcargoodslist>.from(
//             json["shopcargoodslist"].map((x) => Shopcargoodslist.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "shopcartotalnum": shopcartotalnum,
//         "shopcartotalamount": shopcartotalamount,
//         "discountinfo": discountinfo,
//         "shopcargoodslist":
//             List<dynamic>.from(shopcargoodslist.map((x) => x.toJson())),
//       };
// }

// class Shopcargoodslist {
//   Shopcargoodslist({
//     required this.goodsid,
//     required this.goodsname,
//     required this.goodsimgurl,
//     required this.monthsel,
//     required this.choosenum,
//     required this.price,
//     required this.shopcarspces,
//   });

//   String goodsid;
//   String goodsname;
//   String goodsimgurl;
//   String monthsel;
//   String choosenum;
//   String price;
//   List<String> shopcarspces;

//   factory Shopcargoodslist.fromJson(Map<String, dynamic> json) =>
//       Shopcargoodslist(
//         goodsid: json["goodsid"],
//         goodsname: json["goodsname"],
//         goodsimgurl: json["goodsimgurl"],
//         monthsel: json["monthsel"],
//         choosenum: json["choosenum"],
//         price: json["price"],
//         shopcarspces: List<String>.from(json["shopcarspces"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "goodsid": goodsid,
//         "goodsname": goodsname,
//         "goodsimgurl": goodsimgurl,
//         "monthsel": monthsel,
//         "choosenum": choosenum,
//         "price": price,
//         "shopcarspces": List<dynamic>.from(shopcarspces.map((x) => x)),
//       };
// }

// import 'dart:convert';

// MenuDetailConfirmResponseEntity menuDetailConfirmResponseEntityFromJson(String str) => MenuDetailConfirmResponseEntity.fromJson(json.decode(str));

// String menuDetailConfirmResponseEntityToJson(MenuDetailConfirmResponseEntity data) => json.encode(data.toJson());

class MenuShopcarResponseEntity {
  MenuShopcarResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  String code;
  String msg;
  List<ShopCarDatum> data;

  factory MenuShopcarResponseEntity.fromJson(Map<String, dynamic> json) =>
      MenuShopcarResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: List<ShopCarDatum>.from(
            json["data"].map((x) => ShopCarDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShopCarDatum {
  ShopCarDatum({
    required this.shopcartotalnum,
    required this.orderid,
    required this.shopcartotalamount,
    required this.discountinfo,
    required this.shopcargoodslist,
  });

  String shopcartotalnum;
  String orderid;
  String shopcartotalamount;
  String discountinfo;
  List<Shopcargoodslist> shopcargoodslist;

  factory ShopCarDatum.fromJson(Map<String, dynamic> json) => ShopCarDatum(
        shopcartotalnum: json["shopcartotalnum"],
        orderid: json["orderid"],
        shopcartotalamount: json["shopcartotalamount"],
        discountinfo: json["discountinfo"],
        shopcargoodslist: List<Shopcargoodslist>.from(
            json["shopcargoodslist"].map((x) => Shopcargoodslist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shopcartotalnum": shopcartotalnum,
        "orderid": orderid,
        "shopcartotalamount": shopcartotalamount,
        "discountinfo": discountinfo,
        "shopcargoodslist":
            List<dynamic>.from(shopcargoodslist.map((x) => x.toJson())),
      };
}

class Shopcargoodslist {
  Shopcargoodslist({
    required this.goodsid,
    required this.goodsname,
    required this.goodsimgurl,
    required this.monthsel,
    required this.choosenum,
    required this.price,
    required this.shopcarspces,
  });

  String goodsid;
  String goodsname;
  String goodsimgurl;
  String monthsel;
  String choosenum;
  String price;
  List<String> shopcarspces;

  factory Shopcargoodslist.fromJson(Map<String, dynamic> json) =>
      Shopcargoodslist(
        goodsid: json["goodsid"],
        goodsname: json["goodsname"],
        goodsimgurl: json["goodsimgurl"],
        monthsel: json["monthsel"],
        choosenum: json["choosenum"],
        price: json["price"],
        shopcarspces: List<String>.from(json["shopcarspces"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "goodsid": goodsid,
        "goodsname": goodsname,
        "goodsimgurl": goodsimgurl,
        "monthsel": monthsel,
        "choosenum": choosenum,
        "price": price,
        "shopcarspces": List<dynamic>.from(shopcarspces.map((x) => x)),
      };
}
