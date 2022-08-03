///评论列表发起请求数据
class HomeDetailCommentlistRequestEntity {
  HomeDetailCommentlistRequestEntity({
    required this.id,
  });

  String id;

  factory HomeDetailCommentlistRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      HomeDetailCommentlistRequestEntity(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

///评论列表响应数据
class HomeDetailCommentlistResponseEntity {
  HomeDetailCommentlistResponseEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  String code;
  String msg;
  CommetlistData data;

  factory HomeDetailCommentlistResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      HomeDetailCommentlistResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: CommetlistData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class CommetlistData {
  CommetlistData({
    required this.totalcommentnum,
    required this.commentlist,
  });

  String totalcommentnum;
  List<Commentlist> commentlist;

  factory CommetlistData.fromJson(Map<String, dynamic> json) => CommetlistData(
        totalcommentnum: json["totalcommentnum"],
        commentlist: List<Commentlist>.from(
            json["commentlist"].map((x) => Commentlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalcommentnum": totalcommentnum,
        "commentlist": List<dynamic>.from(commentlist.map((x) => x.toJson())),
      };
}

class Commentlist {
  Commentlist({
    required this.iconurl,
    required this.nickname,
    required this.bodycontext,
    required this.likesnum,
    required this.likestate,
    required this.time,
  });

  String iconurl;
  String nickname;
  String bodycontext;
  String likesnum;
  String likestate;
  String time;

  factory Commentlist.fromJson(Map<String, dynamic> json) => Commentlist(
        iconurl: json["iconurl"],
        nickname: json["nickname"],
        bodycontext: json["bodycontext"],
        likesnum: json["likesnum"],
        likestate: json["likestate"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "iconurl": iconurl,
        "nickname": nickname,
        "bodycontext": bodycontext,
        "likesnum": likesnum,
        "likestate": likestate,
        "time": time,
      };
}

class Writebacklist {
  Writebacklist({
    required this.writebackiconurl,
    required this.writebacknickname,
    required this.writebodycontext,
    required this.writebacklikesnum,
    required this.writebacklikestate,
    required this.writebacktime,
  });

  String writebackiconurl;
  String writebacknickname;
  String writebodycontext;
  String writebacklikesnum;
  String writebacklikestate;
  String writebacktime;

  factory Writebacklist.fromJson(Map<String, dynamic> json) => Writebacklist(
        writebackiconurl: json["writebackiconurl"],
        writebacknickname: json["writebacknickname"],
        writebodycontext: json["writebodycontext"],
        writebacklikesnum: json["writebacklikesnum"],
        writebacklikestate: json["writebacklikestate"],
        writebacktime: json["writebacktime"],
      );

  Map<String, dynamic> toJson() => {
        "writebackiconurl": writebackiconurl,
        "writebacknickname": writebacknickname,
        "writebodycontext": writebodycontext,
        "writebacklikesnum": writebacklikesnum,
        "writebacklikestate": writebacklikestate,
        "writebacktime": writebacktime,
      };
}
