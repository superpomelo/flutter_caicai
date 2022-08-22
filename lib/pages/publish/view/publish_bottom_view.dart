/*
 * @Author: superpomelo 
 * @Date: 2022-08-17 14:21:44
 * @LastEditors: superpomelo 
 * @LastEditTime: 2022-08-22 11:38:14
 * @FilePath: /flutter_caicai/lib/pages/publish/view/publish_bottom_view.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///发布底部部分
Widget publishBottom({required void Function() onPressed}) {
  return btnFlatButtonWidget(
      title: '发 布',
      width: ScreenUtil().screenWidth - 5.w,
      circular: 44 / 2,
      onPressed: () {
        onPressed();
      });
}
