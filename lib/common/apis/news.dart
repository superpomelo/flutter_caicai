import 'package:flutter_caicai/common/entitys/categories.dart';
import 'package:flutter_caicai/common/entitys/channels.dart';
import 'package:flutter_caicai/common/entitys/news.dart';
import 'package:flutter_caicai/common/utils/utils.dart';

class CategoryAPI {
  ///分类
  static Future<UserCategoryResponseEntity> categories() async {
    var response = await HttpUtil().get('/categories');
    return UserCategoryResponseEntity.fromJson(response);
  }
}

class NewsAPI {
  ///推荐
  static Future<NewsRecommendResponseEntity> newsRecommend(
      {required NewsRecommendRequestEntity params}) async {
    var response = await HttpUtil().post('/news/recommend', params: params);
    return NewsRecommendResponseEntity.fromJson(response);
  }

  ///频道
  static Future<NewsChannelsResponseEntity> channels() async {
    var response = await HttpUtil().get('/channels');
    return NewsChannelsResponseEntity.fromJson(response);
  }

  ///新闻item
  static Future<NewsItemResponseEntity> newsItem() async {
    var response = await HttpUtil().get('/tags');
    return NewsItemResponseEntity.fromJson(response);
  }
}
