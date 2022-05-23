import 'package:flutter/material.dart';
import 'package:pk_skeleton_null_safe/pk_skeleton_null_safe.dart';

/// 透明背景 AppBar
AppBar transparentAppBar(
    {required BuildContext context,
    Widget? title,
    Widget? leading,
    List<Widget>? actions,
    Color color = Colors.transparent}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title,
    leading: leading,
    actions: actions,
  );
}

/// 骨架屏-卡片
Widget cardListSkeleton() {
  return PKCardListSkeleton(
    isCircularImage: true,
    isBottomLinesActive: false,
    length: 10,
  );
}

// AppBar transparentAppBar(
//     {required BuildContext context, required List<Widget> actions}) {
//   return AppBar(
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     title: const Text(''),
//     leading: IconButton(
//       icon: const Icon(
//         Icons.arrow_back,
//         color: AppColors.primaryText,
//       ),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     ),
//     actions: actions,
//   );
// }
