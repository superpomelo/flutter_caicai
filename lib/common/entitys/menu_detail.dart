///点单页店铺详情请求
class MenuDetailRequestEntity {
  MenuDetailRequestEntity({
    required this.shopid,
  });

  String shopid;

  factory MenuDetailRequestEntity.fromJson(Map<String, dynamic> json) =>
      MenuDetailRequestEntity(
        shopid: json["shopid"],
      );

  Map<String, dynamic> toJson() => {
        "shopid": shopid,
      };
}

///点单页店铺详情响应
class MenuDetailResponseEntity {
  MenuDetailResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  String code;
  String msg;
  MenuDetailData data;

  factory MenuDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      MenuDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: MenuDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class MenuDetailData {
  MenuDetailData({
    required this.shopname,
    required this.shopnotice,
    required this.logourl,
    required this.categorylist,
    required this.shopaddress,
  });

  String shopname;
  String shopnotice;
  String logourl;
  List<Categorylist> categorylist;
  String shopaddress;

  factory MenuDetailData.fromJson(Map<String, dynamic> json) => MenuDetailData(
        shopname: json["shopname"],
        shopnotice: json["shopnotice"],
        logourl: json["logourl"],
        categorylist: List<Categorylist>.from(
            json["categorylist"].map((x) => Categorylist.fromJson(x))),
        shopaddress: json["shopaddress"],
      );

  Map<String, dynamic> toJson() => {
        "shopname": shopname,
        "shopnotice": shopnotice,
        "logourl": logourl,
        "categorylist": List<dynamic>.from(categorylist.map((x) => x.toJson())),
        "shopaddress": shopaddress,
      };
}

class Categorylist {
  Categorylist({
    required this.categoryid,
    required this.categoryname,
    required this.categoryimgurl,
    required this.goodslist,
  });

  String categoryid;
  String categoryname;
  String categoryimgurl;
  List<Goodslist> goodslist;

  factory Categorylist.fromJson(Map<String, dynamic> json) => Categorylist(
        categoryid: json["categoryid"],
        categoryname: json["categoryname"],
        categoryimgurl: json["categoryimgurl"],
        goodslist: List<Goodslist>.from(
            json["goodslist"].map((x) => Goodslist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryid": categoryid,
        "categoryname": categoryname,
        "categoryimgurl": categoryimgurl,
        "goodslist": List<dynamic>.from(goodslist.map((x) => x.toJson())),
      };
}

class Goodslist {
  Goodslist({
    required this.goodsid,
    required this.goodsname,
    required this.goodsimgurl,
    required this.monthsel,
    required this.selnum,
    required this.price,
    required this.specs,
  });

  String goodsid;
  String goodsname;
  String goodsimgurl;
  String monthsel;
  String selnum;
  String price;
  List<Spec> specs;

  factory Goodslist.fromJson(Map<String, dynamic> json) => Goodslist(
        goodsid: json["goodsid"],
        goodsname: json["goodsname"],
        goodsimgurl: json["goodsimgurl"],
        monthsel: json["monthsel"],
        selnum: json["selnum"],
        price: json["price"],
        specs: List<Spec>.from(json["specs"].map((x) => Spec.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "goodsid": goodsid,
        "goodsname": goodsname,
        "goodsimgurl": goodsimgurl,
        "monthsel": monthsel,
        "selnum": selnum,
        "price": price,
        "specs": List<dynamic>.from(specs.map((x) => x.toJson())),
      };
}

class Spec {
  Spec({
    required this.categoryspecname,
    required this.categoryspecid,
    required this.speclist,
  });

  String categoryspecname;
  String categoryspecid;
  List<Speclist> speclist;

  factory Spec.fromJson(Map<String, dynamic> json) => Spec(
        categoryspecname: json["categoryspecname"],
        categoryspecid: json["categoryspecid"],
        speclist: List<Speclist>.from(
            json["speclist"].map((x) => Speclist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryspecname": categoryspecname,
        "categoryspecid": categoryspecid,
        "speclist": List<dynamic>.from(speclist.map((x) => x.toJson())),
      };
}

class Speclist {
  Speclist({
    required this.id,
    required this.name,
    required this.price,
  });

  String id;
  String name;
  String price;

  factory Speclist.fromJson(Map<String, dynamic> json) => Speclist(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
