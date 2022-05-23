// 分类
class UserCategoryResponseEntity {
  UserCategoryResponseEntity({
    required this.data,
  });

  List<Datum> data;

  factory UserCategoryResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserCategoryResponseEntity(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.code,
    required this.title,
  });

  String code;
  String title;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        code: json["code"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
      };
}
