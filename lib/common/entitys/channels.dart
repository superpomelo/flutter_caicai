class NewsChannelsResponseEntity {
  NewsChannelsResponseEntity({
    required this.data,
  });

  List<NewsChannelsDatum> data;

  factory NewsChannelsResponseEntity.fromJson(Map<String, dynamic> json) =>
      NewsChannelsResponseEntity(
        data: List<NewsChannelsDatum>.from(
            json["data"].map((x) => NewsChannelsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NewsChannelsDatum {
  NewsChannelsDatum({
    required this.code,
    required this.title,
  });

  String code;
  String title;

  factory NewsChannelsDatum.fromJson(Map<String, dynamic> json) =>
      NewsChannelsDatum(
        code: json["code"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
      };
}
