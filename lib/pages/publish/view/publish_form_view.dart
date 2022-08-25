import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_caicai/pages/publish/editor/publish_image_editor.dart';
import 'package:flutter_caicai/pages/publish/editor/publish_video_editor.dart';
import 'package:flutter_caicai/pages/publish/view/publish_grid_view.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:path/path.dart' as path;
import 'package:extended_image/extended_image.dart';

class PublishFormView extends StatefulWidget {
  const PublishFormView({Key? key, this.onTypeChanged}) : super(key: key);
  final ValueChanged<List>? onTypeChanged;

  @override
  State<PublishFormView> createState() => _PublishFormViewState();
}

class _PublishFormViewState extends State<PublishFormView> {
  final _selectedAssets = <PublishAssetEntity>[];
  final _images = <int, String>{}; // 资源上传后的回调地址
  final _progress = <String, int>{}; // 资源上传进度
  /// 图片或视频上传组件
  Widget _uploadAssetsView() {
    return PublishGridView.uploadFrom(
      _selectedAssets,
      progress: _progress,
      onAdd: () async {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              cancelButton: CupertinoActionSheetAction(
                child: const Text('取消'),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.of(context).pop();
                },
              ),
              actions: [
                CupertinoActionSheetAction(
                  child: const Text('图片'),
                  onPressed: () {
                    Navigator.pop(context);
                    _openImagePicker();
                  },
                  isDefaultAction: true,
                ),
                CupertinoActionSheetAction(
                  child: const Text('视频'),
                  onPressed: () {
                    Navigator.pop(context);
                    _openImagePicker(isVideo: true);
                  },
                  isDefaultAction: true,
                ),
              ],
            );
          },
        );
      },
      onTap: (assetEntity) async {
        // 预览资源
        debugPrint('PublishGridView - onTap: $assetEntity');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (assetEntity.isVideo()) {
                return PublishVideoEditor(
                  assetEntity,
                  mode: PublishVideoMode.preview,
                  onDelete: () => _onDelete(assetEntity),
                );
              }

              return PublishImageEditor(
                entity: assetEntity,
                onDelete: () => _onDelete(assetEntity),
              );
            },
          ),
        );
      },
      onDelete: _onDelete,
    );
  }

  /// 判断选中资源中是否包含某个资源
  bool _containsAsset(AssetEntity entity) {
    if (_selectedAssets.isEmpty) return false;

    for (var e in _selectedAssets) {
      if (e.type == PublishAssetType.asset && e.entity == entity) {
        return true;
      }
    }

    return false;
  }

  /// 选中资源来自本地相册选择
  List<AssetEntity> _assetSelectedList() {
    final assets = <AssetEntity>[];

    for (var item in _selectedAssets) {
      if (item.type == PublishAssetType.asset) {
        assets.add(item.entity!);
      }
    }
    return assets;
  }

  /// 每次选择一个资源，是图片就跳转裁剪页面，是视频就跳转视频压缩页面
  void _openImagePicker({bool isVideo = false}) async {
    var selectedAssetsCount = _selectedAssets.length;
    var maxAssetsCount = min(selectedAssetsCount + 1, 9);

    if (isVideo) {
      _handleVideo(maxAssetsCount);
    } else {
      _handleImage(maxAssetsCount);
    }
  }

  /// 处理选中的视频
  void _handleVideo(int maxAssetsCount) async {
    final videos = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets: _assetSelectedList(),
        maxAssets: maxAssetsCount,
        requestType: RequestType.video,
        // specialPickerType: SpecialPickerType.wechatMoment,
      ),
    );

    if (videos == null) return;

    for (var video in videos) {
      if (_containsAsset(video) || video.type != AssetType.video) {
        continue;
      }

      final assetEntity = PublishAssetEntity.asset(video);

      File? file = await Navigator.push<File?>(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PublishVideoEditor(assetEntity);
          },
        ),
      );

      if (file != null) {
        debugPrint('---------out file: $file');

        final title = path.basename(file.path);
        debugPrint('-----video file title: $title');

        try {
          final entity =
              await PhotoManager.editor.saveVideo(file, title: title);

          if (entity == null) continue;
          debugPrint('--------可以开始上传视频了');

          _uploadAsset(entity);
        } catch (e) {
          debugPrint('--------视频转换失败: $e');
        }
        break;
      }
    }
  }

  /// 处理选中的图片
  void _handleImage(int maxAssetsCount) async {
    final images = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets: _assetSelectedList(),
        maxAssets: maxAssetsCount,
        requestType: RequestType.image,
        // specialPickerType: SpecialPickerType.wechatMoment,
      ),
    );

    if (images == null) return;

    for (var image in images) {
      if (_containsAsset(image)) continue;

      final assetEntity = PublishAssetEntity.asset(image);

      // 选择了新的图片，去裁剪并回调
      var entity = await Navigator.push<AssetEntity?>(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PublishImageEditor(
              entity: assetEntity,
              mode: ExtendedImageMode.editor,
            );
          },
        ),
      );

      if (entity != null) {
        _uploadAsset(entity);
      }
      break;
    }
  }

  /// 上传图片或视频
  void _uploadAsset(AssetEntity entity) async {
    final assetEntity = PublishAssetEntity.asset(entity);
    setState(() {
      _selectedAssets.add(assetEntity);
    });

    final file = await entity.file;
    final path = file!.path;
    String? result;

    // try {
    //   result = await PublishApi.upload(
    //     path,
    //     progress: (count, total) {
    //       if (total == -1) {
    //         /// 不知道进度
    //         _refresh(() {
    //           _progress[entity.id] = -1;
    //         });
    //         return;
    //       }
    //       var p = (count / total) * 100;
    //       // debugPrint('~~~~~~~~~~~~~~progress: $p, $count, $total');

    //       _refresh(() {
    //         // 这里最高给99，因为100不代表接口完成回调
    //         _progress[entity.id] = max(min(p.ceil(), 99), -1);
    //       });
    //     },
    //   );

    //   debugPrint('-----------_uploadAsset: $result');
    // } catch (e) {
    //   debugPrint('-----------_uploadAsset - error: $e');
    // }

    // if (result == null) {
    //   // 上传失败
    //   _refresh(() {
    //     _progress[entity.id] = -1;
    //   });
    // } else {
    //   // 添加资源上传成功后的路径
    //   int index = _selectedAssets.indexOf(assetEntity);
    //   _images[index] = result;

    //   _refresh(() {
    //     _progress[entity.id] = 100;
    //   });
    // }
  }

  /// 删除资源
  void _onDelete(PublishAssetEntity asset) async {
    int index = _selectedAssets.indexOf(asset);

    // 删除资源的同时，也要删除真正的上传路径
    _images.remove(index);

    // 删除已选
    _selectedAssets.remove(asset);

    // 删除进度
    if (asset.type == PublishAssetType.asset) {
      final entity = asset.entity!;
      var file = await entity.file;
      if (file != null) {
        _progress.remove(file.path);
      }
    }

    // 删除编辑器生成的图片或视频
    // PhotoManager.editor.deleteWithIds([asset.entity.id]);
// 刷新组件
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _uploadAssetsView();
  }
}
