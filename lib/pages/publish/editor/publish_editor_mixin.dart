/*
 * @Author: yhl
 * @Date: 2022-06-10 14:56:18
 * @LastEditors: yhl
 * @LastEditTime: 2022-06-10 15:43:03
 * @Description: 
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/pages/utils/tool_util.dart';

mixin PublishEditorMixin {
  Widget bottomBar();

  Future showDeleteActionSheet();

  Widget bottomActionsView({
    required String left,
    required String right,
    VoidCallback? onLeft,
    VoidCallback? onRight,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      width: double.infinity,
      height: 49,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: throttle(() async {
              if (onLeft != null) onLeft();
            }),
            child: Text(
              left,
              style: TextStyle(
                fontSize: duSetFontSize(14),
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: throttle(() async {
              if (onRight != null) onRight();
            }),
            child: Text(
              right,
              style: TextStyle(
                fontSize: duSetFontSize(14),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomActionDelete() {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 49,
      child: Center(
        child: IconButton(
          onPressed: () => showDeleteActionSheet(),
          icon: const Icon(Icons.delete_forever),
          iconSize: 35,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget bottomActionSheet(
    String title, {
    required BuildContext context,
    VoidCallback? onDelete,
  }) {
    return CupertinoActionSheet(
      title: Text(
        title,
        style: TextStyle(
          fontSize: duSetFontSize(12),
          fontWeight: FontWeight.w500,
          color: const Color(0xff8E8E93),
        ),
      ),
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          '取消',
          style: TextStyle(
            fontSize: duSetFontSize(17),
            fontWeight: FontWeight.w500,
            color: const Color(0xffFF5E00),
          ),
        ),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        CupertinoActionSheetAction(
          child: Text(
            '删除',
            style: TextStyle(
              fontSize: duSetFontSize(17),
              fontWeight: FontWeight.w500,
              color: const Color(0xff007AFF),
            ),
          ),
          onPressed: () {
            if (onDelete != null) {
              Navigator.pop(context);
              onDelete();
            }
          },
          isDefaultAction: true,
        ),
      ],
    );
  }
}
