/*
 * @Author: yhl
 * @Date: 2022-05-24 13:39:08
 * @LastEditors: superpomelo 
 * @LastEditTime: 2022-08-25 14:51:36
 * @Description: 发布-上传图片/视频视图
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/publish/publish_goods_entity.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/pages/utils/string_extension.dart';
import 'package:flutter_caicai/pages/utils/tool_util.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:extended_image/extended_image.dart';

enum PublishPickerType {
  assets,
  goods,
}

enum PublishAssetType {
  asset,
  url,
}

class PublishAssetEntity {
  AssetEntity? entity;
  String? url;
  PublishAssetType type;

  PublishAssetEntity(this.type, {this.entity, this.url}) {
    if (type == PublishAssetType.asset) {
      assert(entity != null, 'PublishAssetEntity 初始化 entity 不能为空');
      return;
    }

    assert(url != null, 'PublishAssetEntity 初始化 url 不能为空');
  }

  factory PublishAssetEntity.asset(AssetEntity entity) {
    return PublishAssetEntity(PublishAssetType.asset, entity: entity);
  }

  factory PublishAssetEntity.url(String url) {
    return PublishAssetEntity(PublishAssetType.url, url: url);
  }

  bool isVideo() {
    if (type == PublishAssetType.asset) {
      return entity!.type == AssetType.video;
    }
    return url!.endsWith('.mp4') || url!.endsWith('.MP4');
  }

  String? videoCover() {
    if (isVideo() && type == PublishAssetType.url) {
      return url!.ossUrl().videoFirstFrameImage();
    }
    return null;
  }
}

class PublishGridView {
  static Widget uploadFrom(
    List<PublishAssetEntity>? assets, {
    Map<String, int?>? progress,
    VoidCallback? onAdd,
    ValueChanged<PublishAssetEntity>? onTap,
    ValueChanged<PublishAssetEntity>? onDelete,
  }) {
    var _count = min(assets?.length ?? 0, 9);
    var _itemCount = _count < 9 ? (_count + 1) : _count;

    return Container(
      padding: EdgeInsets.only(
          top: duSetWidth(0),
          bottom: duSetWidth(18),
          left: duSetWidth(18),
          right: duSetWidth(18)),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text.rich(
          //       TextSpan(
          //         text: '上传图片/视频',
          //         style: TextStyle(
          //           color: const Color(0xFF0B0E11),
          //           fontSize: duSetFontSize(16),
          //           fontWeight: FontWeight.bold,
          //         ),
          //         children: [
          //           TextSpan(
          //             text: '（750*750）',
          //             style: TextStyle(
          //               color: const Color(0xFF8E8E93),
          //               fontSize: duSetFontSize(12),
          //               fontWeight: FontWeight.bold,
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     Text(
          //       '$_count/9',
          //       style: TextStyle(
          //         color: const Color(0xFF0B0E11),
          //         fontSize: duSetFontSize(14),
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 14.w),
          // GridView.count(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   padding: EdgeInsets.only(top: 14.w),
          //   crossAxisCount: 3,
          //   mainAxisSpacing: 10.w,
          //   crossAxisSpacing: 7.w,
          //   childAspectRatio: 1.0,
          //   children: _items,
          // ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: duSetWidth(14)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: duSetWidth(10),
              crossAxisSpacing: duSetWidth(7),
              childAspectRatio: 1.0,
            ),
            itemCount: _itemCount,
            itemBuilder: (context, index) {
              if (index == _itemCount - 1 && _count < 9) {
                return _addItem(
                  onAdd: onAdd,
                );
              }

              return _makeAssetsItem(
                assets![index],
                progress: progress,
                onTap: onTap,
                onDelete: onDelete,
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget goodsFrom(
    List<PublishGoodsEntity>? entities, {
    VoidCallback? onAdd,
    ValueChanged<PublishGoodsEntity>? onDelete,
  }) {
    var _count = min(entities?.length ?? 0, 3);
    var _itemCount = _count < 3 ? (_count + 1) : _count;

    return Container(
      // color: randColor,
      width: double.infinity,
      padding: EdgeInsets.only(
          top: duSetWidth(12),
          bottom: duSetWidth(18),
          left: duSetWidth(18),
          right: duSetWidth(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '认证商家展示',
            style: TextStyle(
              fontSize: duSetFontSize(16),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B0E11),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: duSetWidth(14)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: duSetWidth(10),
              crossAxisSpacing: duSetWidth(7),
              childAspectRatio: duSetWidth(112) / duSetWidth(142),
            ),
            itemCount: _itemCount,
            itemBuilder: (context, index) {
              if (index == _itemCount - 1 && _count < 3) {
                return _addItem(
                  isGoods: true,
                  onAdd: onAdd,
                );
              }

              return _makeGoodItem(
                entities![index],
                onDelete: onDelete,
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget _addItem({
    bool isGoods = false,
    VoidCallback? onAdd,
  }) {
    var _addBtn = ElevatedButton(
      onPressed: () {
        if (onAdd != null) {
          onAdd();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(duSetWidth(8)),
        ),
        elevation: 0,
        primary: const Color(0xFFF5F5F5),
      ),
      child: Icon(
        Icons.add,
        color: const Color(0xFFE3E3E5),
        size: duSetWidth(30),
      ),
    );

    var _item = Padding(
      padding: EdgeInsets.only(top: duSetWidth(7), right: duSetWidth(7)),
      child: _addBtn,
    );

    if (isGoods) {
      _item = Padding(
        padding: EdgeInsets.only(top: duSetWidth(7), right: duSetWidth(7)),
        child: Align(
          alignment: Alignment.topLeft,
          child: AspectRatio(
            aspectRatio: 1,
            child: _addBtn,
          ),
        ),
      );
    }

    return _item;
  }

  static Widget _progressView(int? progress) {
    if (progress != null && progress != -1) {
      return Text(
        '$progress%',
        style: TextStyle(
          color: Colors.white,
          fontSize: duSetFontSize(17),
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return ExtendedImage.asset(
      'assets/images/icon_failed.png',
      width: 27,
      height: 27,
    );
  }

  static Widget _makeAssetsItem(
    PublishAssetEntity asset, {
    Map<String, int?>? progress,
    ValueChanged<PublishAssetEntity>? onTap,
    ValueChanged<PublishAssetEntity>? onDelete,
  }) {
    Widget? _image;
    int? _progressValue;

    if (asset.type == PublishAssetType.asset) {
      final entity = asset.entity!;

      _progressValue = progress?[entity.id];

      _image = AssetEntityImage(
        entity,
        isOriginal: false,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else {
      final cover = asset.videoCover();
      if (cover != null) {
        debugPrint('----------视频封面：$cover');
        _image = ExtendedImage.network(
          cover,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      } else {
        debugPrint('----------图片：${asset.url}');
        _image = ExtendedImage.network(
          asset.url!.ossUrl(),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      }
    }

    return Stack(
      children: [
        InkWell(
          onTap: throttle(() async {
            debugPrint('~~~~~~~~~~onTap: $_progressValue');
            // 预览大图
            if (onTap != null &&
                (_progressValue == null ||
                    _progressValue == -1 ||
                    _progressValue == 100)) {
              onTap(asset);
            }
          }),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(top: duSetWidth(7), right: duSetWidth(7)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(duSetWidth(8)),
              child: Stack(
                children: [
                  _image,
                  Visibility(
                    visible: (_progressValue != null && _progressValue != 100),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      color: const Color(0x99575757),
                      child: _progressView(_progressValue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          width: duSetWidth(21),
          height: duSetWidth(21),
          child: Visibility(
            visible: (_progressValue == null ||
                _progressValue == -1 ||
                _progressValue == 100),
            child: ElevatedButton(
              onPressed: () {
                // 删除图片
                if (onDelete != null) {
                  onDelete(asset);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(duSetWidth(10)),
                ),
                primary: const Color(0xFF8E8E93),
                elevation: 0,
                padding: EdgeInsets.zero,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: duSetWidth(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _makeGoodItem(
    PublishGoodsEntity entity, {
    ValueChanged<PublishGoodsEntity>? onDelete,
  }) {
    var stackView = Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(top: duSetWidth(7), right: duSetWidth(7)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(duSetWidth(8)),
            child: Stack(
              children: [
                ExtendedImage.network(
                  entity.goodsPic ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          width: duSetWidth(21),
          height: duSetWidth(21),
          child: ElevatedButton(
            onPressed: () {
              // 删除图片
              if (onDelete != null) {
                onDelete(entity);
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(duSetWidth(10)),
              ),
              primary: const Color(0xFF8E8E93),
              elevation: 0,
              padding: EdgeInsets.zero,
            ),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: duSetWidth(12),
            ),
          ),
        ),
      ],
    );

    return Column(
      children: [
        Expanded(
          child: stackView,
        ),
        SizedBox(height: duSetWidth(12)),
        Text(
          entity.goodsTitle ?? '',
          style: TextStyle(
            color: const Color(0xFF0B0E11),
            fontSize: duSetFontSize(13),
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
