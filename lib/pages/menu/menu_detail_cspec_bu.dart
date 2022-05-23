import 'package:flutter/material.dart';
import 'package:flutter_caicai/common/entitys/entitys.dart';
import 'package:flutter_caicai/common/utils/utils.dart';
import 'package:flutter_caicai/common/values/values.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

Widget newBluSpec({
  required List spec,
  required Speclist we,
  required Goodslist goodsinfo,
  required Spec e,
  Color bgcolor = Colors.blueGrey,
  Color bodercolor = Colors.transparent,
}) {
  return InkWell(
      onTap: () {
        //查询we在e中的位置
        int index = goodsinfo.specs.indexOf(e);
        spec[index] = we.name;
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Container(
          padding: EdgeInsets.fromLTRB(
              duSetWidth(25), duSetWidth(10), duSetWidth(25), duSetWidth(10)),
          color: spec.contains(we.name) ? Colors.red : bgcolor,
          child: Text(
            we.name,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: duSetFontSize(16),
                color: AppColors.primaryText,
                fontWeight: FontWeight.normal,
                height: 1.3),
          ),
        ),
      ));
}
