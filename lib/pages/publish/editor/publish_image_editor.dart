/*
 * @Author: yhl
 * @Date: 2022-06-06 18:07:42
 * @LastEditors: superpomelo 
 * @LastEditTime: 2022-08-22 14:39:08
 * @Description: 
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_caicai/pages/publish/editor/publish_editor_mixin.dart';
import 'package:flutter_caicai/pages/publish/view/publish_grid_view.dart';
import 'package:flutter_caicai/pages/utils/string_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:image_editor/image_editor.dart';

class PublishImageEditor extends StatefulWidget {
  const PublishImageEditor({
    Key? key,
    required this.entity,
    this.mode = ExtendedImageMode.gesture,
    this.onDelete,
  }) : super(key: key);

  final ExtendedImageMode mode;
  final PublishAssetEntity entity;
  final VoidCallback? onDelete;

  @override
  State<PublishImageEditor> createState() => _PublishImageEditorState();
}

class _PublishImageEditorState extends State<PublishImageEditor>
    with PublishEditorMixin {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  void _onConfirm(BuildContext context) async {
    // 确定裁剪
    final Rect? cropRect = editorKey.currentState?.getCropRect();
    final needCrop = editorKey.currentState?.editAction?.needCrop ?? false;
    final img = editorKey.currentState?.rawImageData;

    if (needCrop && cropRect != null && img != null) {
      ImageEditorOption option = ImageEditorOption();
      option.addOption(ClipOption.fromRect(cropRect));
      option.outputFormat = const OutputFormat.jpeg(100);

      // 裁剪图片
      final file = await ImageEditor.editImageAndGetFile(
        image: img,
        imageEditorOption: option,
      );
      final _path = file.path;

      // 保存到相册
      final fileEntity = await PhotoManager.editor
          .saveImageWithPath(_path, title: path.basename(_path));

      if (fileEntity != null) {
        // 删除会有弹窗
        // final List<String> ret =
        //     await PhotoManager.editor.deleteWithIds([fileEntity.id]);
        // debugPrint('rest ------- $ret, path: ${fileEntity.relativePath}');

        Navigator.pop(context, fileEntity);
        return;
      }
    }

    Navigator.pop(context, widget.entity.entity);
  }

  @override
  Widget build(BuildContext context) {
    final backBtn = IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 24,
      ),
      color: Colors.white,
    );

    final appBar = AppBar(
      // toolbarHeight: ScreenUtil().statusBarHeight + 44,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: backBtn,
    );

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: const Color(0xff222222),
        child: FutureBuilder(
          future: _preview(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              // return snapshot.data as Widget;

              var preview = SizedBox(
                height: double.infinity,
                child: snapshot.data as Widget,
              );

              return Stack(
                children: [
                  preview,
                  Positioned(
                    child: appBar,
                    top: 0,
                    left: 0,
                    right: 0,
                  ),
                  Positioned(
                    child: bottomBar(),
                    // child: const SizedBox.shrink(),
                    left: 0,
                    right: 0,
                    bottom: ScreenUtil().bottomBarHeight,
                  ),
                ],
              );
            }
            return appBar;
          },
        ),
      ),
    );
  }

  Future<Widget> _preview() async {
    // 预览大图
    final cropAspectRatio = CropAspectRatios.ratio1_1;

    if (widget.entity.type == PublishAssetType.asset) {
      final entity = widget.entity.entity!;
      final originFile = await entity.originFile;

      return ExtendedImage.file(
        originFile!,
        fit: BoxFit.contain,
        mode: widget.mode,
        extendedImageEditorKey: editorKey,
        cacheRawData: true,
        initEditorConfigHandler: widget.mode == ExtendedImageMode.editor
            ? (_) {
                return EditorConfig(
                  // maxScale: 8.0,
                  // cornerSize: Size.zero,
                  cornerColor: Colors.white,
                  lineColor: Colors.white,
                  cropRectPadding: const EdgeInsets.all(20.0),
                  hitTestSize: 20.0,
                  cropAspectRatio: cropAspectRatio,
                  // initCropRectType: InitCropRectType.imageRect
                  editorMaskColorHandler: (context, pointerDown) {
                    return Colors.transparent;
                  },
                );
              }
            : null,
      );
    }

    return ExtendedImage.network(
      widget.entity.url!.ossUrl(),
      fit: BoxFit.contain,
      mode: ExtendedImageMode.gesture,
      cacheRawData: true,
    );
  }

  @override
  Widget bottomBar() {
    switch (widget.mode) {
      case ExtendedImageMode.gesture:
        return bottomActionDelete();
      case ExtendedImageMode.editor:
        return bottomActionsView(
          left: '重置',
          right: '确定',
          onLeft: () {
            editorKey.currentState?.reset();
          },
          onRight: () {
            _onConfirm(context);
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Future showDeleteActionSheet() async {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return bottomActionSheet(
          '要删除这张图片吗？',
          context: ctx,
          onDelete: () {
            if (widget.onDelete != null) {
              widget.onDelete!();
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}
