// To parse this JSON data, do
//
//     final userLoginRequestEntity = userLoginRequestEntityFromJson(jsonString);

///首页详情页发起请求
class HomeDetailRequestEntity {
  HomeDetailRequestEntity({
    required this.id,
  });

  String id;

  factory HomeDetailRequestEntity.fromJson(Map<String, dynamic> json) =>
      HomeDetailRequestEntity(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

///首页详情页响应数据
class HomeDetailResponseEntity {
  HomeDetailResponseEntity({
    required this.code,
    required this.data,
    required this.msg,
  });

  String code;
  HomeDetailData data;
  String msg;

  factory HomeDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      HomeDetailResponseEntity(
        code: json["code"],
        data: HomeDetailData.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "msg": msg,
      };
}

class HomeDetailData {
  HomeDetailData({
    required this.writericonurl,
    required this.writerlocation,
    required this.writerusername,
    required this.focusstatus,
    required this.writerimages,
    required this.titlecontant,
    required this.bodycontant,
    required this.time,
    required this.islike,
  });

  String writericonurl;
  Writerlocation writerlocation;
  String writerusername;
  String focusstatus;
  List<String> writerimages;
  String titlecontant;
  String bodycontant;
  String time;
  String islike;

  factory HomeDetailData.fromJson(Map<String, dynamic> json) => HomeDetailData(
        writericonurl: json["writericonurl"],
        writerlocation: Writerlocation.fromJson(json["writerlocation"]),
        writerusername: json["writerusername"],
        focusstatus: json["focusstatus"],
        writerimages: List<String>.from(json["writerimages"].map((x) => x)),
        titlecontant: json["titlecontant"],
        bodycontant: json["bodycontant"],
        time: json["time"],
        islike: json["islike"],
      );

  Map<String, dynamic> toJson() => {
        "writericonurl": writericonurl,
        "writerlocation": writerlocation.toJson(),
        "writerusername": writerusername,
        "focusstatus": focusstatus,
        "writerimages": List<dynamic>.from(writerimages.map((x) => x)),
        "titlecontant": titlecontant,
        "bodycontant": bodycontant,
        "time": time,
        "islike": islike,
      };
}

class Writerlocation {
  Writerlocation({
    required this.writeraddress,
    required this.writerlat,
    required this.writerlon,
  });

  String writeraddress;
  String writerlat;
  String writerlon;

  factory Writerlocation.fromJson(Map<String, dynamic> json) => Writerlocation(
        writeraddress: json["writeraddress"],
        writerlat: json["writerlat"],
        writerlon: json["writerlon"],
      );

  Map<String, dynamic> toJson() => {
        "writeraddress": writeraddress,
        "writerlat": writerlat,
        "writerlon": writerlon,
      };
}
