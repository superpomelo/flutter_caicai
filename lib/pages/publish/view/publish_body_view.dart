/*
 * @Author: superpomelo 
 * @Date: 2022-08-17 14:06:48
 * @LastEditors: superpomelo 
 * @LastEditTime: 2022-08-19 11:27:02
 * @FilePath: /flutter_caicai/lib/pages/publish/view/publish_body_view.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/widgets/textformfield_widget.dart';

///发布文本部分
Widget publishBody() {
  return multilineFrom(
    'title',
    hintText: '添加正文',
    maxLength: 150,
    validator: (value) {},
  );
}
