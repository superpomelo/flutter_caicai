/*
 * @Author: yhl
 * @Date: 2022-07-03 19:02:34
 * @LastEditors: superpomelo 
 * @LastEditTime: 2022-08-19 16:26:48
 * @Description: 
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_caicai/pages/publish/editor/publish_editor_mixin.dart';
import 'package:flutter_caicai/pages/publish/view/publish_grid_view.dart';
import 'package:flutter_caicai/pages/utils/string_extension.dart';
import 'package:flutter_caicai/pages/utils/tool_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_player/video_player.dart';
import 'package:helpers/helpers.dart'
    show OpacityTransition, AnimatedInteractiveViewer;

enum PublishVideoMode {
  editor,
  preview,
}

class PublishVideoEditor extends StatefulWidget {
  const PublishVideoEditor(
    this.assetEntity, {
    Key? key,
    this.mode = PublishVideoMode.editor,
    this.onDelete,
  }) : super(key: key);

  final PublishAssetEntity assetEntity;
  final PublishVideoMode mode;
  final VoidCallback? onDelete;

  @override
  State<PublishVideoEditor> createState() => _PublishVideoEditorState();
}

class _PublishVideoEditorState extends State<PublishVideoEditor>
    with PublishEditorMixin {
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  final double height = 60;

  bool _failedToPreview = false;
  VideoEditorController? _controller;
  VideoPlayerController? _player;

  void _initData() async {
    if (widget.mode == PublishVideoMode.preview) {
      if (widget.assetEntity.type == PublishAssetType.url) {
        _player =
            VideoPlayerController.network(widget.assetEntity.url!.ossUrl())
              ..initialize()
                  .then((_) => setState(() {
                        _player!.setLooping(true);
                      }))
                  .onError((error, stackTrace) => setState(() {
                        _failedToPreview = true;
                      }));
      } else {
        final file = await widget.assetEntity.entity!.file;
        if (file == null) return;

        _controller = VideoEditorController.file(file)
          ..initialize().then((_) => setState(() {}));
      }
    } else {
      final file = await widget.assetEntity.entity!.file;
      if (file == null) return;

      Duration? maxDuration;

      if (file.existsSync()) {
        final videoDuration = widget.assetEntity.entity!.videoDuration;
        debugPrint('-----------videoDuration: $videoDuration');

        const maxLength = 10 * 1024 * 1024; // 假设上传最大为10MB
        final lengthSync = file.lengthSync(); // 获取文件大小

        if (maxLength >= lengthSync) {
          maxDuration = videoDuration;
        } else {
          var scale = maxLength / lengthSync;
          maxDuration = videoDuration * scale;
        }
      }

      debugPrint('-----------maxDuration: $maxDuration');
      _controller = VideoEditorController.file(file,
          maxDuration: maxDuration ?? const Duration(seconds: 30))
        ..initialize().then((_) => setState(() {}));
    }
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _controller?.dispose();
    _player?.dispose();
    super.dispose();
  }

  void _openCropScreen() => Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              PublishCropScreen(controller: _controller!)));

  void _exportVideo() async {
    if (_isExporting.value == true) return;

    debugPrint('----------开始导出视频');
    _controller!.video.pause();
    _exportingProgress.value = 0;
    _isExporting.value = true;
    // NOTE: To use `-crf 1` and [VideoExportPreset] you need `ffmpeg_kit_flutter_min_gpl` package (with `ffmpeg_kit` only it won't work)
    await _controller!
        .exportVideo(
      // preset: VideoExportPreset.medium,
      // customInstruction: "-crf 17",
      onProgress: (stats, value) => _exportingProgress.value = value,
      onCompleted: (file) {
        _isExporting.value = false;
        if (!mounted) return;

        debugPrint(' Video success export!');
        Navigator.pop(context, file);
      },
    )
        .onError((error, stackTrace) {
      debugPrint('Error on export video: $error');
      // AppLoading.showError('视频导出失败');
    });
  }

  List<Widget> _videoPlayer() {
    bool isEditorMode = widget.mode == PublishVideoMode.editor;
    bool _isUrl = false;
    Widget _playView;
    Listenable? _animation;
    VoidFutureCallBack _onTap;

    if (!isEditorMode && widget.assetEntity.type == PublishAssetType.url) {
      _animation = _player!;
      _isUrl = true;
      _onTap = _player!.play;

      _playView = GestureDetector(
        onTap: () {
          setState(() {
            _player!.value.isPlaying ? _player!.pause() : _player!.play();
          });
        },
        child: AspectRatio(
          aspectRatio: _player!.value.aspectRatio,
          child: VideoPlayer(_player!),
        ),
      );
    } else {
      _animation = _controller!.video;
      _onTap = _controller!.video.play;

      _playView = CropGridViewer(
        controller: _controller!,
        showGrid: false,
      );
    }

    return [
      _playView,
      AnimatedBuilder(
        animation: _animation,
        builder: (_, __) => OpacityTransition(
          visible: _isUrl ? !_player!.value.isPlaying : !_controller!.isPlaying,
          child: GestureDetector(
            onTap: _onTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isEditorMode = widget.mode == PublishVideoMode.editor;
    bool initialized = false;
    bool isUrl = false;

    if (!isEditorMode && widget.assetEntity.type == PublishAssetType.url) {
      isUrl = true;
      if (_player != null) initialized = _player!.value.isInitialized;
    } else {
      if (_controller != null) initialized = _controller!.initialized;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isEditorMode
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
            ),
      body: initialized
          ? SafeArea(
              child: isUrl == true
                  ? Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: _videoPlayer(),
                          ),
                        ),
                        bottomBar(),
                      ],
                    )
                  : Column(
                      children: [
                        OpacityTransition(
                          visible: isEditorMode,
                          child: _topNavBar(),
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: _videoPlayer(),
                          ),
                        ),
                        OpacityTransition(
                          visible: isEditorMode,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _trimSlider(),
                          ),
                        ),
                        bottomBar(),
                        ValueListenableBuilder(
                          valueListenable: _isExporting,
                          builder: (_, bool export, __) => OpacityTransition(
                            visible: export,
                            child: AlertDialog(
                              backgroundColor: Colors.white,
                              title: ValueListenableBuilder(
                                valueListenable: _exportingProgress,
                                builder: (_, double value, __) => Text(
                                  "视频处理中 ${(value * 100).ceil()}%",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            )
          : (_failedToPreview
              ? Center(
                  child: TextButton(
                    onPressed: () => _initData(),
                    child: SizedBox(
                      width: ScreenUtil().scaleWidth,
                      height: 200,
                      child: const Text(
                        '视频加载失败，点击重试',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator())),
    );
  }

  Widget _topNavBar() {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () =>
                  _controller!.rotate90Degrees(RotateDirection.left),
              icon: const Icon(
                Icons.rotate_left,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () =>
                  _controller!.rotate90Degrees(RotateDirection.right),
              icon: const Icon(
                Icons.rotate_right,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: _openCropScreen,
              icon: const Icon(
                Icons.crop,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");

  List<Widget> _trimSlider() {
    return [
      AnimatedBuilder(
        animation: _controller!.video,
        builder: (_, __) {
          final duration = _controller!.video.value.duration.inSeconds;
          final pos = _controller!.trimPosition * duration;
          final start = _controller!.minTrim * duration;
          final end = _controller!.maxTrim * duration;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: height / 4),
            child: Row(
              children: [
                Text(
                  formatter(Duration(seconds: pos.toInt())),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Expanded(child: SizedBox()),
                OpacityTransition(
                  visible: _controller!.isTrimming,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        formatter(Duration(seconds: start.toInt())),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formatter(Duration(seconds: end.toInt())),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: height / 4),
        child: TrimSlider(
          controller: _controller!,
          height: height,
          horizontalMargin: height / 4,
          // child: TrimTimeline(
          //   controller: _controller!,
          //   margin: const EdgeInsets.only(top: 10),
          // ),
        ),
      )
    ];
  }

  @override
  Widget bottomBar() {
    /*
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            '取消',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: _exportVideo,
          child: const Text(
            '完成',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
    */

    switch (widget.mode) {
      case PublishVideoMode.preview:
        return bottomActionDelete();
      case PublishVideoMode.editor:
        return bottomActionsView(
            left: '取消',
            right: '完成',
            onLeft: () {
              if (!mounted) return;
              if (_controller!.isTrimmmed == false) {
                Navigator.pop(context);
                return;
              }
              _showCancelActionSheet();
            },
            onRight: throttle(() async {
              _exportVideo();
            }));
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
          '要删除这个视频吗？',
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

  Future _showCancelActionSheet() async {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          title: Text(
            '您确定要放弃所有更改吗？',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff8E8E93),
            ),
          ),
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              '取消',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff007AFF),
              ),
            ),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(ctx);
            },
          ),
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                '放弃更改',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffFF5E00),
                ),
              ),
              onPressed: () async {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              isDefaultAction: true,
            ),
          ],
        );
      },
    );
  }
}

/// 裁剪
class PublishCropScreen extends StatelessWidget {
  const PublishCropScreen({Key? key, required this.controller})
      : super(key: key);

  final VideoEditorController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            Row(children: [
              Expanded(
                child: IconButton(
                  onPressed: () =>
                      controller.rotate90Degrees(RotateDirection.left),
                  icon: const Icon(Icons.rotate_left, color: Colors.white),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () =>
                      controller.rotate90Degrees(RotateDirection.right),
                  icon: const Icon(Icons.rotate_right, color: Colors.white),
                ),
              )
            ]),
            const SizedBox(height: 15),
            Expanded(
              child: AnimatedInteractiveViewer(
                maxScale: 2.4,
                child: CropGridViewer(
                    controller: controller, horizontalMargin: 60),
              ),
            ),
            const SizedBox(height: 15),
            Row(children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "取消",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              buildSplashTap("16:9", 16 / 9,
                  padding: const EdgeInsets.symmetric(horizontal: 10)),
              buildSplashTap("1:1", 1 / 1),
              buildSplashTap("4:5", 4 / 5,
                  padding: const EdgeInsets.symmetric(horizontal: 10)),
              buildSplashTap("NO", null,
                  padding: const EdgeInsets.only(right: 10)),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    //2 WAYS TO UPDATE CROP
                    //WAY 1:
                    controller.updateCrop();
                    /*WAY 2:
                    controller.minCrop = controller.cacheMinCrop;
                    controller.maxCrop = controller.cacheMaxCrop;
                    */
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "确认",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget buildSplashTap(
    String title,
    double? aspectRatio, {
    EdgeInsetsGeometry? padding,
  }) {
    return InkWell(
      onTap: () => controller.preferredCropAspectRatio = aspectRatio,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.aspect_ratio, color: Colors.white),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
