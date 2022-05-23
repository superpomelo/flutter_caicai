import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/entitys/home_detail_commetlist.dart';
import 'package:flutter_caicai/common/utils/utils.dart';

class TuiJAPI {
  ///首页
  static Future<HomeItemResponseEntity> home() async {
    var response = await HttpUtil().post('/home');
    return HomeItemResponseEntity.fromJson(response);
  }

  ///首页详情
  static Future<HomeDetailResponseEntity> homedetail(
      {required HomeDetailRequestEntity params}) async {
    var response = await HttpUtil().post('/home/detail', params: params);
    return HomeDetailResponseEntity.fromJson(response);
  }

  ///首页详情获取评论列表
  static Future<HomeDetailCommentlistResponseEntity> homedetailcommentlist(
      {required HomeDetailCommentlistRequestEntity params}) async {
    var response =
        await HttpUtil().post('/home/detail/commentlist', params: params);
    return HomeDetailCommentlistResponseEntity.fromJson(response);
  }
}
