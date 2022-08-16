/*
 * @Author: yhl
 * @Date: 2022-05-31 17:31:34
 * @LastEditors: superpomelo 
 * @LastEditTime: 2022-08-16 16:24:55
 * @Description: 
 */
import 'dart:convert';

List<PublishGoodsEntity>? publishGoodsEntityFromJson(List? list) =>
    list?.map((e) => PublishGoodsEntity.fromJson(e)).toList();

String publishGoodsEntityToJson(List<PublishGoodsEntity>? data) =>
    json.encode(data?.map((e) => e.toJson()).toList());

class PublishGoodsEntity {
  PublishGoodsEntity({
    this.goodsId,
    this.goodsPic,
    this.goodsTitle,
    this.minPrice,
  });

  String? goodsId;
  String? goodsPic;
  String? goodsTitle;
  int? minPrice;

  factory PublishGoodsEntity.fromJson(Map<String, dynamic> json) =>
      PublishGoodsEntity(
        goodsId: json["goodsId"],
        goodsPic: json["goodsPic"],
        goodsTitle: json["goodsTitle"],
        minPrice: json["minPrice"],
      );

  Map<String, dynamic> toJson() => {
        "goodsId": goodsId,
        "goodsPic": goodsPic,
        "goodsTitle": goodsTitle,
        "minPrice": minPrice,
      };
}
