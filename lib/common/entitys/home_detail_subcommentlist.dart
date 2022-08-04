// To parse this JSON data, do
//
//     final homeDetailSubcommentlistRequestEntity = homeDetailSubcommentlistRequestEntityFromJson(jsonString);

import 'dart:convert';

HomeDetailSubcommentlistRequestEntity
    homeDetailSubcommentlistRequestEntityFromJson(String str) =>
        HomeDetailSubcommentlistRequestEntity.fromJson(json.decode(str));

String homeDetailSubcommentlistRequestEntityToJson(
        HomeDetailSubcommentlistRequestEntity data) =>
    json.encode(data.toJson());

class HomeDetailSubcommentlistRequestEntity {
  HomeDetailSubcommentlistRequestEntity({
    this.fid,
    this.page,
    this.pagesize,
  });

  String? fid;
  String? page;
  String? pagesize;

  factory HomeDetailSubcommentlistRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      HomeDetailSubcommentlistRequestEntity(
        fid: json["fid"],
        page: json["page"],
        pagesize: json["pagesize"],
      );

  Map<String, dynamic> toJson() => {
        "fid": fid,
        "page": page,
        "pagesize": pagesize,
      };
}

// To parse this JSON data, do
//
//     final homeDetailSubcommentlistEntity = homeDetailSubcommentlistEntityFromJson(jsonString);

HomeDetailSubcommentlistEntity homeDetailSubcommentlistEntityFromJson(
        String str) =>
    HomeDetailSubcommentlistEntity.fromJson(json.decode(str));

String homeDetailSubcommentlistEntityToJson(
        HomeDetailSubcommentlistEntity data) =>
    json.encode(data.toJson());

class HomeDetailSubcommentlistEntity {
  HomeDetailSubcommentlistEntity({
    this.code,
    this.msg,
    this.data,
  });

  String? code;
  String? msg;
  SubData? data;

  factory HomeDetailSubcommentlistEntity.fromJson(Map<String, dynamic> json) =>
      HomeDetailSubcommentlistEntity(
        code: json["code"],
        msg: json["msg"],
        data: SubData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class SubData {
  SubData({
    this.writebacklist,
    this.writebacklistnum,
  });

  List<Writebacklist>? writebacklist;
  String? writebacklistnum;

  factory SubData.fromJson(Map<String, dynamic> json) => SubData(
        writebacklist: List<Writebacklist>.from(
            json["writebacklist"].map((x) => Writebacklist.fromJson(x))),
        writebacklistnum: json["writebacklistnum"],
      );

  Map<String, dynamic> toJson() => {
        "writebacklist":
            List<dynamic>.from(writebacklist!.map((x) => x.toJson())),
        "writebacklistnum": writebacklistnum,
      };
}

class Writebacklist {
  Writebacklist({
    this.writebackiconurl,
    this.writebacknickname,
    this.writebodycontext,
    this.writebacklikesnum,
    this.writebacklikestate,
    this.writebacktime,
  });

  String? writebackiconurl;
  String? writebacknickname;
  String? writebodycontext;
  String? writebacklikesnum;
  String? writebacklikestate;
  String? writebacktime;

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
