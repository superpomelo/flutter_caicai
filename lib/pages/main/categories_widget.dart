import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/categories.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';

/// 分类
Widget newsCategoriesWidget(
    {required List<Datum> categories,
    required String selCategoryCode,
    required Function(Datum) onTap}) {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map<Widget>((item) {
          return Container(
            alignment: Alignment.center,
            height: duSetHeight(52),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              child: Text(
                item.title,
                style: TextStyle(
                  color: selCategoryCode == item.code
                      ? AppColors.secondaryElementText
                      : AppColors.primaryText,
                  fontSize: duSetFontSize(18),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                onTap(item);
              },
            ),
          );
        }).toList(),
      ));
}
