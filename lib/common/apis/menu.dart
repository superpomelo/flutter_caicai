import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/entitys/menu_detail_confirm.dart';
import 'package:flutter_caicai/common/entitys/menu_detail_recommandlist.dart';
import 'package:flutter_caicai/common/entitys/menu_shopcar.dart';
import 'package:flutter_caicai/common/utils/utils.dart';

class MenuAPI {
  ///点单首页推荐店铺
  static Future<MenuCommentlistResponseEntity> recommend(
      {required MenuCommentlistRequestEntity params}) async {
    var response = await HttpUtil().post('/menu', params: params);
    return MenuCommentlistResponseEntity.fromJson(response);
  }

  ///店铺详情
  static Future<MenuDetailResponseEntity> shopdetail(
      {required MenuDetailRequestEntity params}) async {
    var response = await HttpUtil().post('/menu/shophome', params: params);
    return MenuDetailResponseEntity.fromJson(response);
  }

  ///店铺详情商品推荐
  static Future<MenuDetailRecommandlistResponseEntity> shophomerecommend(
      {required MenuDetailRecommandlistRequestEntity params}) async {
    var response =
        await HttpUtil().post('/menu/shophomerecommend', params: params);
    return MenuDetailRecommandlistResponseEntity.fromJson(response);
  }

  ///店铺详情购物车
  static Future<MenuShopcarResponseEntity> shopcar(
      {required MenuShopcarRequestEntity params}) async {
    var response = await HttpUtil().post('/menu/shopcar', params: params);
    return MenuShopcarResponseEntity.fromJson(response);
  }

  ///店铺详情购物车新增商品
  static Future<MenuAddgoodsResponseEntity> changeshopcar(
      {required MenuAddgoodsRequestEntity params}) async {
    var response = await HttpUtil().post('/menu/changeshopcar', params: params);
    return MenuAddgoodsResponseEntity.fromJson(response);
  }

  ///确认订单
  static Future<MenuDetailConfirmResponseEntity> confirmorder(
      {required MenuDetailConfirmRequestEntity params}) async {
    var response =
        await HttpUtil().post('/menu/shophome/confirm', params: params);
    return MenuDetailConfirmResponseEntity.fromJson(response);
  }
}
