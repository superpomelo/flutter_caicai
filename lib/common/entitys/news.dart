///新闻推荐 request
class NewsRecommendRequestEntity {
  NewsRecommendRequestEntity({
    required this.categoryCode,
    required this.channelCode,
    required this.tag,
    required this.keyword,
  });

  String categoryCode;
  String channelCode;
  String tag;
  String keyword;

  factory NewsRecommendRequestEntity.fromJson(Map<String, dynamic> json) =>
      NewsRecommendRequestEntity(
        categoryCode: json["categoryCode"],
        channelCode: json["channelCode"],
        tag: json["tag"],
        keyword: json["keyword"],
      );

  Map<String, dynamic> toJson() => {
        "categoryCode": categoryCode,
        "channelCode": channelCode,
        "tag": tag,
        "keyword": keyword,
      };
}

///新闻推荐 response
class NewsRecommendResponseEntity {
  NewsRecommendResponseEntity({
    required this.thumbnail,
    required this.title,
    required this.category,
    required this.addtime,
    required this.author,
    required this.url,
    required this.id,
  });

  String thumbnail;
  String title;
  String category;
  String addtime;
  String author;
  String url;
  String id;

  factory NewsRecommendResponseEntity.fromJson(Map<String, dynamic> json) =>
      NewsRecommendResponseEntity(
        thumbnail: json["thumbnail"],
        title: json["title"],
        category: json["category"],
        addtime: json["addtime"],
        author: json["author"],
        url: json["url"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "title": title,
        "category": category,
        "addtime": addtime,
        "author": author,
        "url": url,
        "id": id,
      };
}

//newitem
class NewsItemResponseEntity {
  NewsItemResponseEntity({
    required this.counts,
    required this.pagesize,
    required this.pages,
    required this.page,
    required this.items,
  });

  String counts;
  String pagesize;
  String pages;
  String page;
  List<Item> items;

  factory NewsItemResponseEntity.fromJson(Map<String, dynamic> json) =>
      NewsItemResponseEntity(
        counts: json["counts"],
        pagesize: json["pagesize"],
        pages: json["pages"],
        page: json["page"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "counts": counts,
        "pagesize": pagesize,
        "pages": pages,
        "page": page,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.id,
    required this.title,
    required this.category,
    required this.thumbnail,
    required this.author,
    required this.addtime,
    required this.url,
  });

  String id;
  String title;
  String category;
  String thumbnail;
  String author;
  String addtime;
  String url;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        author: json["author"],
        addtime: json["addtime"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category,
        "thumbnail": thumbnail,
        "author": author,
        "addtime": addtime,
        "url": url,
      };
}
