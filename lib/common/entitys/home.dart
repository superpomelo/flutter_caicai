///首页响应数据
class HomeItemResponseEntity {
  HomeItemResponseEntity({
    required this.code,
    required this.data,
    required this.msg,
  });

  String code;
  List<HomeDatum> data;
  String msg;

  factory HomeItemResponseEntity.fromJson(Map<String, dynamic> json) =>
      HomeItemResponseEntity(
        code: json["code"],
        data: List<HomeDatum>.from(
            json["data"].map((x) => HomeDatum.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "msg": msg,
      };
}

class HomeDatum {
  HomeDatum({
    required this.id,
    required this.title,
    required this.imageurl,
    required this.iconurl,
    required this.username,
    required this.hot,
  });

  int id;
  String title;
  String imageurl;
  String iconurl;
  String username;
  String hot;

  factory HomeDatum.fromJson(Map<String, dynamic> json) => HomeDatum(
        id: json["id"],
        title: json["title"],
        imageurl: json["imageurl"],
        iconurl: json["iconurl"],
        username: json["username"],
        hot: json["hot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageurl": imageurl,
        "iconurl": iconurl,
        "username": username,
        "hot": hot,
      };
}
